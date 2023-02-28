class Message {
  final String id;
  final String content;
  final String timestamp;

  Message({required this.id, required this.content, required this.timestamp});

  Message.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        timestamp = json['timestamp'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'timestamp': timestamp,
      };
}
