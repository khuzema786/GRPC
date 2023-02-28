import 'package:grpc_chat/protos/chat.pbgrpc.dart' as grpc;
import 'package:grpc/grpc.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:grpc_chat/models/message.dart';

class ChatService {
  grpc.User user = grpc.User();
  late grpc.ChatClient stub;

  late ClientChannel channel = ClientChannel(
    "0.tcp.in.ngrok.io",
    port: 16353,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );

  /// Event is raised when message has been sent to the server successfully
  final void Function(Message message) onSentSuccess;

  /// Event is raised when message sending is failed
  final void Function(Message message, String error) onSentError;

  /// Event is raised when message has been received from the server
  final void Function(Message message) onReceivedSuccess;

  /// Event is raised when message receiving is failed
  final void Function(String error) onReceivedError;

  ChatService(String name, this.onSentSuccess, this.onSentError,
      this.onReceivedSuccess, this.onReceivedError) {
    user
      ..clearName()
      ..name = name
      ..clearId()
      ..id = sha256.convert(utf8.encode(user.name)).toString();

    stub = grpc.ChatClient(channel);
  }

  void sendMessage(String body) async {
    var timestamp = DateTime.now().toIso8601String();
    try {
      await stub.sendMsg(grpc.Message()
        ..id = user.id
        ..content = body
        ..timestamp = timestamp);
      onSentSuccess(Message(content: body, id: user.id, timestamp: timestamp));
    } catch (e) {
      channel.shutdown();

      onSentError(Message(content: body, id: user.id, timestamp: timestamp),
          e.toString());

      Future.delayed(const Duration(seconds: 30), () {
        channel = ClientChannel(
          "0.tcp.in.ngrok.io",
          port: 16353,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        );
        stub = grpc.ChatClient(channel);

        sendMessage(body);
      });
    }
  }

  void recieveMessage() async {
    grpc.Connect connect = grpc.Connect()
      ..user = user
      ..active = true;

    try {
      await for (var msg in stub.recieveMsg(connect)) {
        onReceivedSuccess(Message(
            id: msg.id, content: msg.content, timestamp: msg.timestamp));
      }
    } catch (e) {
      channel.shutdown();

      onReceivedError(e.toString());

      Future.delayed(const Duration(seconds: 30), () {
        channel = ClientChannel(
          "0.tcp.in.ngrok.io",
          port: 16353,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ),
        );
        stub = grpc.ChatClient(channel);

        recieveMessage();
      });
    }
  }
}
