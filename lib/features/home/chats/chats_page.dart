import 'dart:math';

import 'package:custom_clippers/custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';
import 'package:what_app/features/home/chats/wigets/chat_text_field_widget.dart';
import 'package:what_app/features/home/chats/wigets/message_card.dart';
import 'package:what_app/features/home/controllers/chat_controller.dart';
import 'package:what_app/models/user_model.dart';
import '../../../common/routes/app_routes.dart';
import '../../../common/shared_widgets/custom_icon_button_widget.dart';
import 'wigets/yellow_card.dart';

final pageStorageBucket = PageStorageBucket();

class ChatsPage extends ConsumerWidget {
  final UserModel user;

  const ChatsPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
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
              const SizedBox(
                width: 10,
              ),
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
      body: Stack(
        children: [
          Image(
            height: double.maxFinite,
            width: double.maxFinite,
            image: const AssetImage('assets/images/bg_chat.png'),
            fit: BoxFit.cover,
            color: context.color.photoIconBgColor,
          ),
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream:
                      ref.watch(chatController).getAllOneToOneMessage(user.uid),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      return ListView.builder(
                        itemCount: 15,
                        itemBuilder: (_, index) {
                          final random = Random().nextInt(14);
                          return Container(
                            alignment: random.isEven
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: random.isEven ? 150 : 15,
                              right: random.isEven ? 15 : 150,
                            ),
                            child: ClipPath(
                              clipper: UpperNipMessageClipperTwo(
                                random.isEven
                                    ? MessageType.send
                                    : MessageType.receive,
                                nipWidth: 8,
                                nipHeight: 10,
                                bubbleRadius: 12,
                              ),
                              child: Shimmer.fromColors(
                                baseColor: random.isEven
                                    ? context.color.greyColor!.withOpacity(.3)
                                    : context.color.greyColor!.withOpacity(.2),
                                highlightColor: random.isEven
                                    ? context.color.greyColor!.withOpacity(.4)
                                    : context.color.greyColor!.withOpacity(.3),
                                child: Container(
                                  height: 40,
                                  width: 170 +
                                      double.parse(
                                        (random * 2).toString(),
                                      ),
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return PageStorage(
                        bucket: pageStorageBucket,
                        child: ListView.builder(
                          key: const PageStorageKey('chat_page_list'),
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          controller: scrollController,
                          itemBuilder: (_, index) {
                            final message = snapshot.data![index];
                            final isSender = message.senderId ==
                                FirebaseAuth.instance.currentUser!.uid;

                            final haveNip = (index == 0) ||
                                (index == snapshot.data!.length - 1 &&
                                    message.senderId !=
                                        snapshot.data![index - 1].senderId) ||
                                (message.senderId !=
                                        snapshot.data![index - 1].senderId &&
                                    message.senderId ==
                                        snapshot.data![index + 1].senderId) ||
                                (message.senderId !=
                                        snapshot.data![index - 1].senderId &&
                                    message.senderId !=
                                        snapshot.data![index + 1].senderId);

                            return Column(
                              children: [
                                if (index == 0) const YellowCard(),
                                if ((index == 0) ||
                                    (index == snapshot.data!.length - 1 &&
                                        message.timeSent.day >
                                            snapshot.data![index - 1].timeSent
                                                .day) ||
                                    (message.timeSent.day >
                                            snapshot.data![index - 1].timeSent
                                                .day &&
                                        message.timeSent.day <=
                                            snapshot
                                                .data![index + 1].timeSent.day))
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                        color: context.color.receiverChatCardBg,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        DateFormat.yMMMd()
                                            .format(message.timeSent),
                                        style: TextStyle(
                                          color: context.color.greyColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                MessageCard(
                                  isSender: isSender,
                                  haveNip: haveNip,
                                  message: message,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 95,
                child: ChatTextFieldWidget(
                  receiverId: user.uid,
                  scrollController: scrollController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
