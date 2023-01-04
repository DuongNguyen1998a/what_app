import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:what_app/models/user_model.dart';

import '../common/helpers/show_alert_dialog.dart';
import '../common/helpers/show_loading_dialog.dart';
import '../common/routes/app_routes.dart';
import 'storage_repository.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    fireStore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore fireStore;

  const AuthRepository({
    required this.firebaseAuth,
    required this.fireStore,
  });

  void sendVerificationCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      debugPrint(phoneNumber);
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          debugPrint(
              '[firebaseAuth.verifyPhoneNumber]-[verificationCompleted]');
        },
        verificationFailed: (FirebaseAuthException exception) {
          debugPrint('[firebaseAuth.verifyPhoneNumber]-[verificationFailed]');
          debugPrint(exception.message ?? '');
          showAlertDialog(context: context, message: exception.message ?? '');
        },
        codeSent: (String verificationId, int? resendToken) async {
          debugPrint('[firebaseAuth.verifyPhoneNumber]-[codeSent]');
          context.go(
            AppRoutes.verification,
            extra: {
              'phone': phoneNumber,
              'verificationId': verificationId,
            },
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint(
              '[firebaseAuth.verifyPhoneNumber]-[codeAutoRetrievalTimeout]');
        },
        timeout: const Duration(minutes: 2),
      );
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, message: e.message ?? '');
    }
  }

  void verifyCode({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      showLoadingDialog(context: context, message: 'Loading...');
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await firebaseAuth.signInWithCredential(credential).then((value) {
        debugPrint(value.toString());
      });
      if (!mounted) return;
      context.pop();
      context.go(AppRoutes.userInfo);
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, message: e.message ?? '');
      context.pop();
    }
  }

  void saveUser({
    required String username,
    required BuildContext context,
    required bool mounted,
    required ProviderRef providerRef,
    required File avatarFile,
  }) async {
    try {
      UserModel userModel = UserModel(
        lastSeen: 0,
        username: '',
        uid: '',
        profileImageUrl: '',
        active: false,
        phoneNumber: '',
        groupId: [],
      );

      if (firebaseAuth.currentUser != null) {
        debugPrint('Signed in');

        /// update user information in firebase auth
        await firebaseAuth.currentUser!.updateDisplayName(username);
        providerRef
            .read(storageProvider)
            .uploadAvatarToStorage(
                'uid_${firebaseAuth.currentUser!.uid}', avatarFile)
            .then((value) {
          firebaseAuth.currentUser!.updatePhotoURL(value);

          /// create model store data into firebase cloud database
          userModel = UserModel(
            lastSeen: 0,
            username: username,
            uid: firebaseAuth.currentUser!.uid,
            profileImageUrl: value,
            active: true,
            phoneNumber: firebaseAuth.currentUser!.phoneNumber!,
            groupId: [],
          );

          /// store data into firebase cloud database
          fireStore
              .collection('users')
              .doc(firebaseAuth.currentUser!.uid)
              .set(userModel.toMap());
        });


        if (!mounted) return;
        context.go(AppRoutes.home);
      }
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
