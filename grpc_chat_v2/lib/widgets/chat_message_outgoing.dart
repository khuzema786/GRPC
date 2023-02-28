import 'package:flutter/material.dart';

import 'package:grpc_chat_v2/models/message.dart';
import 'package:grpc_chat_v2/models/message_outgoing.dart';

/// Outgoing message author name
const String _name = "Me";

/// ChatMessageOutgoingController is 'Controller' class that allows change message properties
class ChatMessageOutgoingController {
  /// Outgoing message content
  MessageOutgoing message;

  /// Controller raises this event when status has been changed
  void Function(
          MessageOutgoingStatus oldStatus, MessageOutgoingStatus newStatus)?
      onStatusChanged;

  /// Constructor
  ChatMessageOutgoingController({required this.message});

  /// setStatus is method to update status of the outgoing message
  /// It raises onStatusChanged event
  void setStatus(MessageOutgoingStatus newStatus) {
    var oldStatus = message.status;
    if (oldStatus != newStatus) {
      message.status = newStatus;
      if (onStatusChanged != null) {
        onStatusChanged!(oldStatus, newStatus);
      }
    }
  }
}

/// ChatMessageOutgoing is widget to display outgoing to server message
class ChatMessageOutgoing extends StatefulWidget implements ChatMessage {
  /// Outgoing message content
  @override
  final MessageOutgoing message;

  /// Message state controller
  final ChatMessageOutgoingController controller;

  /// Controller of animation for message widget
  @override
  final AnimationController animationController;

  /// Constructor
  ChatMessageOutgoing(
      {required this.message, required this.animationController})
      : controller = ChatMessageOutgoingController(message: message),
        super(key: ObjectKey(message.id));

  @override
  State createState() => ChatMessageOutgoingState(
      animationController: animationController, controller: controller);
}

/// State for ChatMessageOutgoing widget
class ChatMessageOutgoingState extends State<ChatMessageOutgoing> {
  /// Message state controller
  final ChatMessageOutgoingController controller;

  /// Controller of animation for message widget
  final AnimationController animationController;

  /// Constructor
  ChatMessageOutgoingState(
      {required this.controller, required this.animationController}) {
    // Subscribe to event "message status has been changed"
    controller.onStatusChanged = onStatusChanged;
  }

  /// Subscription to event "message status has been changed"
  void onStatusChanged(
      MessageOutgoingStatus oldStatus, MessageOutgoingStatus newStatus) {
    setState(() {});
  }

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
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text(_name[0])),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_name, style: Theme.of(context).textTheme.subtitle1),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(controller.message.text),
                  ),
                ],
              ),
            ),
            Icon(controller.message.status == MessageOutgoingStatus.SENT
                ? Icons.done
                : Icons.access_time),
          ],
        ),
      ),
    );
  }
}
