import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what_app/repositories/auth_repository.dart';

final homeController = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return HomeController(authRepository: authRepository);
});

class HomeController {
  final AuthRepository authRepository;

  const HomeController({
    required this.authRepository,
  });

  void updateStatusAndLastSeen() {
    authRepository.updateStatusAndLastSeen();
  }
}
