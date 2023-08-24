class MessageModel {
  final String id;
  final String senderId;
  final String content;
  final String createdAt;
  final String contentType;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.content,
    required this.createdAt,
    required this.contentType,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      senderId: json['senderId'],
      content: json['content'],
      createdAt: json['createdAt'],
      contentType: json['contentType']
    );
  }
}
