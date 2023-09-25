class RichiestaAppunto {
  final String id;
  final String senderId;
  final String receiverId;
  final String contentType;
  final Map<String, dynamic> content;
  final DateTime createdAt;
  final String replyBy;
  final String status;

  RichiestaAppunto({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.contentType,
    required this.content,
    required this.createdAt,
    required this.replyBy,
    required this.status,
  });

  factory RichiestaAppunto.fromJson(Map<String, dynamic> json) {
    return RichiestaAppunto(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      contentType: json['contentType'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      replyBy: json['replyBy'],
      status: json['status'],
    );
  }
}