import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what_app/common/helpers/show_alert_dialog.dart';
import 'package:what_app/models/user_model.dart';

final contactRepositoryProvider = Provider((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  return ContactRepository(firebaseAuth: firebaseAuth, fireStore: fireStore,);
});

class ContactRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore fireStore;

  const ContactRepository({
    required this.firebaseAuth,
    required this.fireStore,
  });

  Future<List<List>> getAllContacts() async {
    try {
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
      );
      final usersCollection = await fireStore.collection('users').get();

      List<UserModel> users = [];

      usersCollection.docs.map((e) {
        users.add(UserModel.fromMap(e.data()));
      }).toList();

      return [users, contacts];
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }
}
