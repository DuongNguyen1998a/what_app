import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/routes/app_routes.dart';

class ChatsContainer extends StatelessWidget {
  const ChatsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Chats'),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(AppRoutes.contacts);
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
