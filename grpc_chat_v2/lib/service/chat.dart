import 'package:grpc/grpc.dart';

import 'package:grpc_chat_v2/protos/chat/chat.pbgrpc.dart' as grpc;
import 'package:grpc_chat_v2/protos/chat/google/protobuf/empty.pb.dart';
import 'package:grpc_chat_v2/models/message_outgoing.dart';
import 'package:grpc_chat_v2/models/message_incoming.dart';

/// CHANGE TO IP ADDRESS OF YOUR SERVER IF IT IS NECESSARY
const serverIP = "0.tcp.in.ngrok.io";
const serverPort = 16353;

/// ChatService client implementation
class ChatService {
  /// Flag is indicating that client is shutting down
  bool _isShutdown = false;

  /// gRPC client channel to send messages to the server
  grpc.ChatServiceClient stub;

  /// gRPC client channel to receive messages from the server
  static ClientChannel? channel = ClientChannel(
    serverIP, // Your IP here or localhost
    port: serverPort,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      idleTimeout: Duration(seconds: 10),
    ),
  );

  /// Event is raised when message has been sent to the server successfully
  final void Function(MessageOutgoing message) onSentSuccess;

  /// Event is raised when message sending is failed
  final void Function(MessageOutgoing message, String error) onSentError;

  /// Event is raised when message has been received from the server
  final void Function(MessageIncoming message) onReceivedSuccess;

  /// Event is raised when message receiving is failed
  final void Function(String error) onReceivedError;

  /// Constructor
  ChatService({
    required this.onSentSuccess,
    required this.onSentError,
    required this.onReceivedSuccess,
    required this.onReceivedError,
  }) : stub = grpc.ChatServiceClient(channel!);

  // Shutdown client
  Future<void> shutdown() async {
    _isShutdown = true;
    _shutdownSend();
    _shutdownReceive();
  }

  // Shutdown client (send channel)
  void _shutdownSend() {
    channel?.shutdown();
    channel = null;
  }

  // Shutdown client (receive channel)
  void _shutdownReceive() {
    channel?.shutdown();
    channel = null;
  }

  /// Send message to the server
  void send(MessageOutgoing message) {
    if (channel == null) {
      channel = ClientChannel(
        serverIP, // Your IP here or localhost
        port: serverPort,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          idleTimeout: Duration(seconds: 10),
        ),
      );
      stub = grpc.ChatServiceClient(channel!);
    }

    var request = grpc.Message.create();
    request.id = message.id!;
    request.text = message.text;

    stub.send(request).then((_) {
      // call for success handler
      var sentMessage = MessageOutgoing(
          id: message.id,
          text: message.text,
          status: MessageOutgoingStatus.SENT);
      onSentSuccess(sentMessage);
    }).catchError((e) {
      if (!_isShutdown) {
        // invalidate current client
        _shutdownSend();

        // call for error handler
        onSentError(message, e.toString());

        // try to send again
        Future.delayed(const Duration(seconds: 30), () {
          send(message);
        });
      }
    });
  }

  /// Start listening messages from the server
  void startListening() {
    if (channel == null) {
      channel = ClientChannel(
        serverIP, // Your IP here or localhost
        port: serverPort,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          idleTimeout: Duration(seconds: 10),
        ),
      );
      stub = grpc.ChatServiceClient(channel!);
    }

    var stream = stub.subscribe(Empty.create());

    stream.forEach((msg) {
      var message = MessageIncoming(text: msg.text, id: msg.id);
      onReceivedSuccess(message);
    }).then((_) {
      // raise exception to start listening again
      throw Exception("stream from the server has been closed");
    }).catchError((e) {
      if (!_isShutdown) {
        // invalidate current client
        _shutdownReceive();

        // call for error handler
        onReceivedError(e.toString());

        // start listening again
        Future.delayed(const Duration(seconds: 30), () {
          startListening();
        });
      }
    });
  }
}
