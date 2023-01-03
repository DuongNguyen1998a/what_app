import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what_app/repositories/auth_repository.dart';

final loginController = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginController(authRepository: authRepository);
});

class LoginController {
  final AuthRepository authRepository;

  const LoginController({
    required this.authRepository,
  });

  sendVerificationCode({
    required BuildContext context,
    required String phoneNumber,
  }) {
    authRepository.sendVerificationCode(
      context: context,
      phoneNumber: phoneNumber,
    );
  }
}
