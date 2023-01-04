import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';
import 'package:what_app/models/user_model.dart';

import '../../../common/routes/app_routes.dart';
import '../../../common/utils/app_colors.dart';

class ProfilePage extends StatelessWidget {
  final UserModel user;

  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: BackButton(
          onPressed: () {
            context.go(AppRoutes.chats, extra: user);
          },
        ),
        title: const Text('User Profile'),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(user.profileImageUrl),
            ),
          ),
          Text(
            user.username,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            user.phoneNumber,
            style: TextStyle(
              fontSize: 20,
              color: context.color.greyColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Last seen 2 days ago',
            style: TextStyle(
              color: context.color.greyColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              IconWithText(text: 'Call', icon: Icons.call),
              IconWithText(text: 'Video', icon: Icons.video_call),
              IconWithText(text: 'Search', icon: Icons.search),
            ],
          ),
        ],
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final String text;
  final IconData icon;

  const IconWithText({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: AppColors.greenDark,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(text, style: const TextStyle(
            color: AppColors.greenDark,
          ),),
        ],
      ),
    );
  }
}
