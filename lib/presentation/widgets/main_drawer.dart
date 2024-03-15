import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homelinker/core/app_router.gr.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        children: [
          ListTile(
            title: const Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.lightBlue,
                ),
                SizedBox(width: 10),
                Text(
                  'Settngs',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              AutoRouter.of(context).push(const SettingsRoute());
              AutoRouter.of(context).popForced();
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.lightBlue,
                ),
                SizedBox(width: 10),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              AutoRouter.of(context).push(const ProfileRoute());
              AutoRouter.of(context).popForced();
            },
          ),
        ],
      ),
    );
  }
}
