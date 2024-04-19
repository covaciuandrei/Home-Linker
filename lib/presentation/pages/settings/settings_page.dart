import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/settings/settings_cubit.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    BlocProvider.of<SettingsCubit>(context).loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, BaseState>(
      listener: (context, state) {
        if (state is LoggedOutSuccessfullyState) {
          AutoRouter.of(context).pushAndPopUntil(
            const IntroductiveRoute(),
            predicate: (route) => false,
          );
        } else if (state is AccountDeletedSuccessfullyState) {
          AutoRouter.of(context).pushAndPopUntil(
            const IntroductiveRoute(),
            predicate: (route) => false,
          );
        }
      },
      builder: (context, state) {
        return LoadingScreen(
          loading: state is PendingState,
          child: Scaffold(
            appBar: const MainAppBar(title: 'Settings'),
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
                              onPressed: () {
                                _showDeleteBottomSheet(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    MainButton(
                      width: 240,
                      text: 'Logout',
                      onPressed: () =>
                          BlocProvider.of<SettingsCubit>(context).logOut(),
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
          ),
        );
      },
    );
  }
}

void _showDeleteBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete Account'),
              onTap: () {
                BlocProvider.of<SettingsCubit>(context).deleteAccount();
                AutoRouter.of(context).popForced(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () {
                AutoRouter.of(context).popForced(context);
              },
            ),
          ],
        ),
      );
    },
  );
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
