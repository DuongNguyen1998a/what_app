import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:what_app/common/helpers/show_loading_dialog.dart';
import 'package:what_app/repositories/storage_repository.dart';

import '../common/helpers/show_alert_dialog.dart';
import '../common/routes/app_routes.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth firebaseAuth;

  const AuthRepository({
    required this.firebaseAuth,
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
      if (firebaseAuth.currentUser != null) {
        debugPrint('Signed in');
        await firebaseAuth.currentUser!.updateDisplayName(username);
        providerRef
            .read(storageProvider)
            .uploadAvatarToStorage(
                'uid_${firebaseAuth.currentUser!.uid}', avatarFile)
            .then((value) {
          firebaseAuth.currentUser!.updatePhotoURL(value);
        });
        if (!mounted) return;
        context.go(AppRoutes.home);
        debugPrint(firebaseAuth.currentUser!.toString());
      } else {
        debugPrint(' Not signed in');
      }
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
