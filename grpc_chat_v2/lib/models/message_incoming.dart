import 'package:grpc_chat_v2/models/message.dart';

/// MessageIncoming is class defining incoming message data (id and text)
class MessageIncoming extends Message {
  /// Constructor
  MessageIncoming({required String text, required String id})
      : super(text: text, id: id);
}
