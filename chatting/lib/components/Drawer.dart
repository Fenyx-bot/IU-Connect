import 'package:chatting/components/MyListTile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSFriendsTap;
  final void Function()? onSettingsTap;
  final void Function()? onSignOutTap;
  const MyDrawer({super.key, required this.onProfileTap, required this.onSignOutTap, required this.onSettingsTap, required this.onSFriendsTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          //Header
          DrawerHeader(child: Icon(Icons.person, size: 64, color: Theme.of(context).appBarTheme.iconTheme!.color,),),


          //home
          MyListTile(icon: Icons.developer_board, text: "T H E \t B O A R D", onTap: () => Navigator.pop(context),),

          //messages
          MyListTile(icon: Icons.people, text: "F R I E N D S", onTap: onSFriendsTap),

          //profile
          MyListTile(icon: Icons.person, text: "P R O F I L E", onTap: onProfileTap),

          //settings
          MyListTile(icon: Icons.settings, text: "S E T T I N G S", onTap: onSettingsTap),

          const Expanded(child: SizedBox()),

          //sign out
          MyListTile(icon: Icons.logout, text: "L O G O U T", onTap: onSignOutTap),

          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}