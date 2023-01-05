import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:what_app/models/last_message_model.dart';
import 'package:what_app/models/user_model.dart';
import '../common/enum/message_type.dart';
import '../common/helpers/show_alert_dialog.dart';
import '../models/message_model.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository(
    fireStore: FirebaseFirestore.instance,
    firebaseAuth: FirebaseAuth.instance,
  );
});

class ChatRepository {
  final FirebaseFirestore fireStore;
  final FirebaseAuth firebaseAuth;

  const ChatRepository({
    required this.fireStore,
    required this.firebaseAuth,
  });

  void saveAsLastMessage({
    required UserModel sender,
    required UserModel receiver,
    required String textMessage,
    required DateTime timeSent,
    required String receiverId,
  }) async {
    final receiverLastMessage = LastMessageModel(
      username: sender.username,
      profileImageUrl: sender.profileImageUrl,
      contactId: sender.uid,
      timeSent: timeSent,
      lastMessage: textMessage,
    );

    await fireStore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(firebaseAuth.currentUser!.uid)
        .set(receiverLastMessage.toMap());

    final senderLastMessage = LastMessageModel(
      username: receiver.username,
      profileImageUrl: receiver.profileImageUrl,
      contactId: receiver.uid,
      timeSent: timeSent,
      lastMessage: textMessage,
    );

    await fireStore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .set(senderLastMessage.toMap());
  }

  void saveMessage({
    required String receiverId,
    required String textMessage,
    required DateTime timeSent,
    required String textMessageId,
    required String senderUsername,
    required String receiverUsername,
    required MessageType messageType,
  }) async {
    final message = MessageModel(
      senderId: firebaseAuth.currentUser!.uid,
      receiverId: receiverId,
      textMessage: textMessage,
      type: MessageType.text,
      timeSent: timeSent,
      messageId: textMessageId,
      isSeen: false,
    );

    // sender
    await fireStore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());

    // receiver
    await fireStore
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());
  }

  void sendTextMessage({
    required BuildContext context,
    required String textMessage,
    required String receiverId,
    required UserModel senderData,
  }) async {
    try {
      final timeSent = DateTime.now();
      final receiverDataMap =
          await fireStore.collection('users').doc(receiverId).get();
      final receiverData = UserModel.fromMap(receiverDataMap.data()!);
      final textMessageId = const Uuid().v1();

      saveMessage(
        receiverId: receiverId,
        textMessage: textMessage,
        timeSent: timeSent,
        textMessageId: textMessageId,
        senderUsername: senderData.username,
        receiverUsername: receiverData.username,
        messageType: MessageType.text,
      );

      saveAsLastMessage(
        sender: senderData,
        receiver: receiverData,
        textMessage: textMessage,
        timeSent: timeSent,
        receiverId: receiverId,
      );
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  Stream<List<LastMessageModel>> getAllLastMessages() {
    return fireStore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<LastMessageModel> contacts = [];
      for (var document in event.docs) {
        final lastMessage = LastMessageModel.fromMap(document.data());
        final userData = await fireStore
            .collection('users')
            .doc(lastMessage.contactId)
            .get();
        final user = UserModel.fromMap(userData.data()!);
        contacts.add(
          LastMessageModel(
            username: user.username,
            profileImageUrl: user.profileImageUrl,
            contactId: lastMessage.contactId,
            timeSent: lastMessage.timeSent,
            lastMessage: lastMessage.lastMessage,
          ),
        );
      }
      return contacts;
    });
  }

  Stream<List<MessageModel>> getAllOneToOneMessage(String receiverId) {
    return fireStore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var message in event.docs) {
        messages.add(MessageModel.fromMap(message.data()));
      }
      return messages;
    });
  }
}
