import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what_app/repositories/auth_repository.dart';

final userInfoController = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return UserInfoController(authRepository: authRepository, providerRef: ref);
});

class UserInfoController {
  final AuthRepository authRepository;
  final ProviderRef providerRef;

  const UserInfoController({
    required this.authRepository,
    required this.providerRef,
  });

  saveUser({
    required String username,
    required BuildContext context,
    required bool mounted,
    required File avatarFile,
  }) {
    authRepository.saveUser(
      username: username,
      context: context,
      mounted: mounted,
      avatarFile: avatarFile,
      providerRef: providerRef,
    );
  }
}
