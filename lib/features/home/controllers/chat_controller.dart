import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what_app/models/user_model.dart';
import 'package:what_app/repositories/chat_repository.dart';

import '../../../models/last_message_model.dart';
import '../../../models/message_model.dart';

final chatController = Provider((ref) {
  return ChatController(
      chatRepository: ref.watch(chatRepositoryProvider), providerRef: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef providerRef;

  const ChatController({
    required this.chatRepository,
    required this.providerRef,
  });

  void sendTextMessage({
    required BuildContext context,
    required String textMessage,
    required String receiverId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data() != null) {
        final senderUser = UserModel.fromMap(value.data()!);
        chatRepository.sendTextMessage(
          context: context,
          textMessage: textMessage,
          receiverId: receiverId,
          senderData: senderUser,
        );
      }
    });
  }

  Stream<List<LastMessageModel>> getAllLastMessages() {
    return chatRepository.getAllLastMessages();
  }

  Stream<List<MessageModel>> getAllOneToOneMessage(String receiverId) {
    return chatRepository.getAllOneToOneMessage(receiverId);
  }
}
