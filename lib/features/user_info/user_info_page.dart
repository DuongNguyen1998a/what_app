import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';
import 'package:what_app/features/user_info/controllers/user_info_controller.dart';
import 'package:what_app/features/user_info/widgets/image_picker_button_widget.dart';

import '../../common/shared_widgets/custom_elevated_button_widget.dart';
import '../../common/shared_widgets/custom_textfield_widget.dart';

class UserInfoPage extends ConsumerStatefulWidget {
  final String? profileImageUrl;

  const UserInfoPage({
    Key? key,
    this.profileImageUrl,
  }) : super(key: key);

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  late TextEditingController usernameController;
  File? imagePickerFromSource;

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

  openGallery() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePickerFromSource = File(image!.path);
    });
    if (!mounted) return;
    context.pop();
  }

  openCamera() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imagePickerFromSource = File(image!.path);
    });
    if (!mounted) return;
    context.pop();
  }

  showBottomSheetImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 30,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: context.color.greyColor!.withOpacity(0.2),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(width: 15),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    splashRadius: 22,
                    iconSize: 22,
                    padding: EdgeInsets.zero,
                    splashColor: Colors.transparent,
                    constraints: const BoxConstraints(minWidth: 40),
                    icon: Icon(
                      Icons.close_outlined,
                      color: context.color.greyColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Profile Photos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Divider(
                color: context.color.greyColor!.withOpacity(0.3),
                thickness: 0.5,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 32, right: 16, top: 10, bottom: 32),
                    child: ImagePickerButtonWidget(
                      onTap: () {
                        openCamera();
                      },
                      text: 'Camera',
                      iconData: Icons.camera_alt_rounded,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 32),
                    child: ImagePickerButtonWidget(
                      onTap: () {
                        openGallery();
                      },
                      text: 'Gallery',
                      iconData: Icons.photo_camera_back_rounded,
                    ),
                  ),
                ],
              ),
            ],
          );
        });
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
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                showBottomSheetImagePicker(context);
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: imagePickerFromSource != null
                        ? Colors.transparent
                        : context.color.greyColor!.withOpacity(0.4),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.color.photoIconBgColor,
                    image: widget.profileImageUrl != null &&
                                widget.profileImageUrl!.isNotEmpty ||
                            imagePickerFromSource != null
                        ? DecorationImage(
                            image: widget.profileImageUrl != null &&
                                    widget.profileImageUrl!.isNotEmpty
                                ? NetworkImage(widget.profileImageUrl!)
                                    as ImageProvider
                                : FileImage(imagePickerFromSource!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3, right: 3),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      size: 48,
                      color: imagePickerFromSource == null &&
                              widget.profileImageUrl == null
                          ? context.color.photoIconColor
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                Icon(Icons.emoji_emotions_outlined,
                    color: context.color.photoIconColor),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButtonWidget(
        onPressed: () {
          ref.read(userInfoController).saveUser(
                username: usernameController.text,
                context: context,
                mounted: mounted,
                avatarFile: imagePickerFromSource!,
              );
        },
        text: 'NEXT',
        width: 90,
      ),
    );
  }
}
