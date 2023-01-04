import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:what_app/common/extensions/custom_theme_extension.dart';
import 'package:what_app/common/shared_widgets/custom_icon_button_widget.dart';
import 'package:what_app/features/home/controllers/contact_controller.dart';

import '../../common/routes/app_routes.dart';
import '../../common/utils/app_colors.dart';

class ChatsContactsContainer extends ConsumerWidget {
  const ChatsContactsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.go(AppRoutes.home);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select contact',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            ref.watch(contactController).when(
                  data: (data) {
                    return Text(
                      '${data[1].length} contacts',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    );
                  },
                  error: (e, s) => Text(
                    e.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  loading: () => const Text(
                    'counting...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
          ],
        ),
        elevation: 1,
        actions: [
          CustomIconButtonWidget(onTap: () {}, icon: Icons.search),
          CustomIconButtonWidget(onTap: () {}, icon: Icons.more_vert),
        ],
      ),
      body: ref.watch(contactController).when(
            data: (data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'Contacts on WhatsApp',
                      style: TextStyle(
                        color: context.color.greyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: data[0].length + data[1].length,
                        itemBuilder: (context, index) {
                          return index < data[0].length ? ListTile(
                            contentPadding: const EdgeInsets.only(
                                left: 20, right: 10, top: 0, bottom: 0),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                              context.color.greyColor!.withOpacity(0.3),
                              backgroundImage: NetworkImage(data[0][index].profileImageUrl),
                            ),
                            title: Text(data[0][index].username),
                            subtitle: const Text('Hey there! I\'m using WhatsApp'),
                          ) : ListTile(
                            contentPadding: const EdgeInsets.only(
                                left: 20, right: 10, top: 0, bottom: 0),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                              context.color.greyColor!.withOpacity(0.3),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(data[1][(index - data[0].length)].displayName),
                            trailing: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.greenDark,
                              ),
                              child: const Text('INVITE'),
                            ),
                          );
                        }),
                  ),
                ],
              );
            },
            error: (e, s) => Center(
              child: Text(e.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
