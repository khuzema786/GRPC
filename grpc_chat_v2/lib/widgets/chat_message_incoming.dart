import 'package:flutter/material.dart';

import 'package:grpc_chat_v2/models/message.dart';

/// Incoming message author name
const String _server = "Server";

/// ChatMessageIncoming is widget to display incoming from server message
class ChatMessageIncoming extends StatelessWidget implements ChatMessage {
  /// Incoming message content
  @override
  final Message message;

  /// Controller of animation for message widget
  @override
  final AnimationController animationController;

  /// Constructor
  ChatMessageIncoming(
      {required this.message, required this.animationController})
      : super(key: ObjectKey(message.id));

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(_server, style: Theme.of(context).textTheme.subtitle1),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(message.text),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                  backgroundColor: Colors.pink.shade600,
                  child: Text(_server[0])),
            ),
          ],
        ),
      ),
    );
  }
}
