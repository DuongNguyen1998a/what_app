import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';
import 'package:what_app/features/home/controllers/chat_controller.dart';

import '../../../common/routes/app_routes.dart';
import '../../../models/user_model.dart';

class ChatsContainer extends ConsumerWidget {
  const ChatsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: StreamBuilder(
        stream: ref.watch(chatController).getAllLastMessages(),
        builder: (_, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapShot.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final lastMessageData = snapShot.data![index];
                  return ListTile(
                    onTap: () {
                      context.go(AppRoutes.chats, extra: UserModel(
                        username: lastMessageData.username,
                        uid: lastMessageData.contactId,
                        profileImageUrl: lastMessageData.profileImageUrl,
                        active: true,
                        lastSeen: 0,
                        phoneNumber: '0',
                        groupId: [],
                      ),);
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(lastMessageData.username),
                        Text(
                          DateFormat.Hm().format(lastMessageData.timeSent),
                          style: TextStyle(
                            fontSize: 13,
                            color: context.color.greyColor,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        lastMessageData.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: context.color.greyColor),
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        lastMessageData.profileImageUrl,
                      ),
                      radius: 24,
                    ),
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(AppRoutes.contacts);
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
