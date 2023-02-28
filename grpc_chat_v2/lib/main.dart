import 'package:flutter/material.dart';

import 'package:grpc_chat_v2/screens/chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "GRPC Chat App",
      home: ChatScreen(),
    );
  }
}
