import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:what_app/models/user_model.dart';

import '../../../common/routes/app_routes.dart';
import '../../../common/shared_widgets/custom_icon_button_widget.dart';

class ChatsPage extends StatelessWidget {
  final UserModel user;

  const ChatsPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go(AppRoutes.contacts);
          },
        ),
        title: InkWell(
          onTap: () {
            context.go(AppRoutes.profile, extra: user);
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(user.profileImageUrl),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Last seen',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        elevation: 1,
        actions: [
          CustomIconButtonWidget(onTap: () {}, icon: Icons.video_call),
          CustomIconButtonWidget(onTap: () {}, icon: Icons.call),
          CustomIconButtonWidget(onTap: () {}, icon: Icons.more_vert),
        ],
      ),
    );
  }
}
