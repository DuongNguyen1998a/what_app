import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what_app/repositories/auth_repository.dart';

final verificationController = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return VerificationController(authRepository: authRepository);
});

class VerificationController {
  final AuthRepository authRepository;

  const VerificationController({
    required this.authRepository,
  });

  verifyCode({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
    required bool mounted,
  }) {
    authRepository.verifyCode(
      context: context,
      verificationId: verificationId,
      smsCode: smsCode,
      mounted: mounted,
    );
  }
}
