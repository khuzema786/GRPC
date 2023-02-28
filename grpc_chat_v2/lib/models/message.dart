import 'package:flutter/material.dart';

/// Message is class defining message data (id and text)
class Message {
  /// id is unique ID of message
  final String? id;

  /// text is content of message
  final String text;

  /// Class constructor
  Message({required this.text, String? id}) : id = id ?? UniqueKey().toString();
}

/// ChatMessage is base abstract class for outgoing and incoming message widgets
abstract class ChatMessage extends Widget {
  const ChatMessage({super.key});

  /// Message content
  Message get message;

  /// Controller of animation for message widget
  AnimationController get animationController;
}
