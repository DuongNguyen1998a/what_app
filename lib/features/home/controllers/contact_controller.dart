import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/contact_repository.dart';

final contactController = FutureProvider((ref) {
  final contactRepository = ref.watch(contactRepositoryProvider);
  return contactRepository.getAllContacts();
});