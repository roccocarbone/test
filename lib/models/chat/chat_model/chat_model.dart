import 'package:student_link/models/chat/message/message_model.dart';
import 'package:student_link/models/chat/user_chat_model/user_chat_model.dart';

class ChatModel {
  final String id;
  final UserModelChat user;
  final MessageModel lastMessage;

  ChatModel({
    required this.id,
    required this.user,
    required this.lastMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> userJson, Map<String, dynamic> messageJson) {
    return ChatModel(
      id: userJson['id'],
      user: UserModelChat.fromJson(userJson),
      lastMessage: MessageModel.fromJson(messageJson),
    );
  }
}