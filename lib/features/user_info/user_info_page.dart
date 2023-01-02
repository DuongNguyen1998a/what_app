import 'package:flutter/material.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';

import '../../common/shared_widgets/custom_elevated_button_widget.dart';
import '../../common/shared_widgets/custom_textfield_widget.dart';

class UserInfoPage extends StatefulWidget {
  final String? profileImageUrl;
  const UserInfoPage({Key? key, this.profileImageUrl,}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {

  late TextEditingController usernameController;

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Profile info',
          style: TextStyle(color: context.color.authAppbarTextColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Please provide your name and an optional profile photo',
              textAlign: TextAlign.center,
              style: TextStyle(color: context.color.greyColor),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.color.greyColor!.withOpacity(0.4),
                    // color: imageGallery == null
                    //     ? Colors.transparent
                    //     : context.color.greyColor!.withOpacity(0.4),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.color.photoIconBgColor,
                    // image: imageGallery != null ||
                    //     imageCamera != null ||
                    //     widget.profileImageUrl != null && widget.profileImageUrl!.isNotEmpty
                    //     ? DecorationImage(
                    //   image: imageGallery != null
                    //       ? MemoryImage(imageGallery!)
                    //       : widget.profileImageUrl != null &&
                    //       widget.profileImageUrl!.isNotEmpty
                    //       ? NetworkImage(widget.profileImageUrl!)
                    //       : FileImage(imageCamera!) as ImageProvider,
                    //   fit: BoxFit.cover,
                    // )
                       // : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3, right: 3),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      size: 48,
                      color: context.color.photoIconColor,
                      // color: imageGallery == null &&
                      //     imageCamera == null &&
                      //     widget.profileImageUrl == null
                      //     ? context.color.photoIconColor
                      //     : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: CustomTextFieldWidget(
                    controller: usernameController,
                    hintText: 'Type your name here',
                    textAlign: TextAlign.left,
                    autoFocus: true,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.emoji_emotions_outlined, color: context.color.photoIconColor),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButtonWidget(
        onPressed: () {},
        text: 'NEXT',
        width: 90,
      ),
    );
  }
}
