import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';
import 'package:what_app/features/home/controllers/chat_controller.dart';

import '../../../../common/shared_widgets/custom_icon_button_widget.dart';
import '../../../../common/utils/app_colors.dart';

class ChatTextFieldWidget extends ConsumerStatefulWidget {
  final String receiverId;
  final ScrollController scrollController;

  const ChatTextFieldWidget({
    Key? key,
    required this.receiverId,
    required this.scrollController,
  }) : super(key: key);

  @override
  ConsumerState<ChatTextFieldWidget> createState() =>
      _ChatTextFieldWidgetState();
}

class _ChatTextFieldWidgetState extends ConsumerState<ChatTextFieldWidget> {
  late TextEditingController messageTextController;
  bool isMessageIconEnabled = false;

  void sendTextMessage() async {
    if (isMessageIconEnabled) {
      ref.read(chatController).sendTextMessage(
            context: context,
            textMessage: messageTextController.text,
            receiverId: widget.receiverId,
          );
      messageTextController.clear();
    }
    await Future.delayed(const Duration(milliseconds: 100));
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void initState() {
    messageTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    messageTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageTextController,
              maxLines: 4,
              minLines: 1,
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    isMessageIconEnabled = false;
                  });
                } else {
                  setState(() {
                    isMessageIconEnabled = true;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyle(
                  color: context.color.greyColor,
                ),
                filled: true,
                fillColor: context.color.chatTextFieldBg,
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: Material(
                  color: Colors.transparent,
                  child: CustomIconButtonWidget(
                    onTap: () {},
                    icon: Icons.emoji_emotions_outlined,
                    iconColor: Theme.of(context).listTileTheme.iconColor,
                  ),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RotatedBox(
                      quarterTurns: 45,
                      child: CustomIconButtonWidget(
                        onTap: () {},
                        icon: Icons.attach_file,
                        iconColor: Theme.of(context).listTileTheme.iconColor,
                      ),
                    ),
                    CustomIconButtonWidget(
                      onTap: () {},
                      icon: Icons.camera_alt_outlined,
                      iconColor: Theme.of(context).listTileTheme.iconColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          CustomIconButtonWidget(
            icon: isMessageIconEnabled ? Icons.send : Icons.mic_none,
            onTap: () {
              sendTextMessage();
            },
            background: AppColors.greenDark,
            iconColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
