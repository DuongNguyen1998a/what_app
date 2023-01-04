import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/routes/app_routes.dart';
import '../../common/shared_widgets/custom_icon_button_widget.dart';
import 'calls_container.dart';
import 'chats_container.dart';
import 'status_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const ChatsContainer(),
      const StatusContainer(),
      const CallsContainer(),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'WhatsApp',
            style: TextStyle(letterSpacing: 1),
          ),
          elevation: 1,
          actions: [
            CustomIconButtonWidget(onTap: () {}, icon: Icons.search),
            CustomIconButtonWidget(onTap: () {
              FirebaseAuth.instance.signOut().then((_) {
                context.go(AppRoutes.login);
              });
            }, icon: Icons.more_vert),
          ],
          bottom: const TabBar(
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: TabBarView(
          children: tabs,
        ),
      ),
    );
  }
}
