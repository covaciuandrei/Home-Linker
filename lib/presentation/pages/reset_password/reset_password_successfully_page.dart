import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';

class ResetPasswordSuccessfullyPage extends StatelessWidget {
  const ResetPasswordSuccessfullyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: BlueShadowBackground(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Flexible(
                  child: Text(
                    'Parola a fost resetata cu succes.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 36),
                MainButton(
                    text: 'Gata',
                    onPressed: () {
                      AutoRouter.of(context).pushAndPopUntil(
                        const IntroductiveRoute(),
                        predicate: (route) => false,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

