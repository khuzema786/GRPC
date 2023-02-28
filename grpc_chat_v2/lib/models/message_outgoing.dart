import 'package:grpc_chat_v2/models/message.dart';
import 'package:uuid/uuid.dart';

/// Outgoing message statuses
/// UNKNOWN - message just created and is not sent yet
/// SENT - message is sent to the server successfully
enum MessageOutgoingStatus { UNKNOWN, SENT }

/// MessageOutgoing is class defining outgoing message data (id and text) and status
class MessageOutgoing extends Message {
  /// Outgoing message status
  MessageOutgoingStatus status;

  /// Constructor
  MessageOutgoing(
      {required String text,
      String? id,
      this.status = MessageOutgoingStatus.UNKNOWN})
      : super(text: text, id: id);
}
