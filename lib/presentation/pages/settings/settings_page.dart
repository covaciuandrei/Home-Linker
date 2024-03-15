import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/settings/settings_cubit.dart';
import 'package:homelinker/presentation/pages/introductive/introductive_page.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, BaseState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: const MainAppBar(title: ''),
            body: BlueShadowBackground(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    const SvgIcon(iconName: 'avatar', size: 200),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SettingsOptionRow(
                              icon: Icons.privacy_tip_rounded,
                              text: 'Privacy policy',
                              onPressed: () {},
                            ),
                            Container(
                              height: 0.5,
                              color: Colors.white,
                            ),
                            SettingsOptionRow(
                              icon: Icons.library_books_rounded,
                              text: 'Termens and conditions',
                              onPressed: () {},
                            ),
                            Container(
                              height: 0.5,
                              color: Colors.white,
                            ),
                            SettingsOptionRow(
                              icon: Icons.delete_forever_rounded,
                              text: 'Delete Account',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    LongMainButton(
                      text: 'Logout',
                      onPressed: () {},
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30, top: 50),
                      child: Text(
                        'Version 1.0 @ 2023',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class SettingsOptionRow extends StatelessWidget {
  const SettingsOptionRow({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
