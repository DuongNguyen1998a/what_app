import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:what_app/features/home/controllers/home_controller.dart';

import '../../common/routes/app_routes.dart';
import '../../common/shared_widgets/custom_icon_button_widget.dart';
import 'tabs/calls_container.dart';
import 'tabs/chats_container.dart';
import 'tabs/status_container.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  late Timer timer;

  void updateStatusAndLastSeen() {
    ref.read(homeController).updateStatusAndLastSeen();
  }

  @override
  void initState() {
    updateStatusAndLastSeen();
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

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
