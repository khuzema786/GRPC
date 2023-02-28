import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:grpc_chat/lifecycle.dart';
import 'package:grpc_chat/service/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grpc_chat/models/message.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  TextEditingController controller = TextEditingController();

  final StreamController _streamController =
      StreamController<Message>.broadcast();

  /// 'outgoing message sent to the server' event
  void onSentSuccess(Message message) {
    debugPrint("message \"${message.content}\" sent to the server");
    _streamController.add(message);
  }

  /// 'failed to send message' event
  void onSentError(Message message, String error) {
    debugPrint(
        "FAILED to send message \"${message.content}\" to the server: $error");
  }

  /// 'new incoming message received from the server' event
  void onReceivedSuccess(Message message) {
    debugPrint("received message from the server: ${message.content}");
    _streamController.add(message);
  }

  /// 'failed to receive messages' event
  void onReceivedError(String error) {
    debugPrint("FAILED to receive messages from the server: $error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose a Username"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              TextField(
                controller: controller,
              ),
              MaterialButton(
                child: const Text("Submit"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MessagePage(
                          ChatService(controller.text, onSentSuccess,
                              onSentError, onReceivedSuccess, onReceivedError),
                          controller.text,
                          _streamController),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MessagePage extends StatefulWidget {
  final ChatService service;
  final String userName;
  final StreamController _streamController;

  const MessagePage(this.service, this.userName, this._streamController,
      {super.key});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late TextEditingController controller;
  late List<Message> messages;
  late String uid;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? messages_ = prefs.getStringList('messages:$uid');
    setState(() {
      if (messages_ != null) {
        messages = messages_
            .map((message) => Message.fromJson(jsonDecode(message)))
            .toList();
      }
    });
  }

  setData(List<dynamic> messages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('messages:$uid',
        messages.map((message) => jsonEncode(message)).toList());
  }

  @override
  void initState() {
    super.initState();
    messages = [];
    uid = sha256.convert(utf8.encode(widget.userName)).toString();
    widget.service.recieveMessage();
    getData();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    widget.service.channel.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Page"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: controller,
              ),
            ),
            MaterialButton(
              child: const Text("Submit"),
              onPressed: () {
                widget.service.sendMessage(controller.text);
                controller.clear();
              },
            ),
            Flexible(
              child: StreamBuilder(
                  stream: widget._streamController.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && messages.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasData) {
                      messages.add(snapshot.data!);
                      setData(messages);
                    }

                    messages.sort((a, b) => a.timestamp
                        .toString()
                        .compareTo(b.timestamp.toString()));

                    return ListView(
                      children: messages
                          .toSet()
                          .map((msg) => ListTile(
                                leading: Text(msg.id.substring(0, 4)),
                                title: Text(msg.content),
                                subtitle: Text(msg.timestamp),
                              ))
                          .toList(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
