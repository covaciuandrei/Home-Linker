import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_text_field.dart';

@RoutePage()
class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final oldPasswordTextController = TextEditingController();
    final newPasswordTextController = TextEditingController();
    final repeatNewPasswordTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: BlueShadowBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MainTextField(
                  textController: oldPasswordTextController,
                  placeholder: 'Old Password',
                ),
                const SizedBox(height: 20),
                MainTextField(
                  textController: newPasswordTextController,
                  placeholder: 'New Password',
                ),
                const SizedBox(height: 20),
                MainTextField(
                  textController: repeatNewPasswordTextController,
                  placeholder: 'Repeat New Password',
                ),
                const SizedBox(height: 40),
                MainButton(
                    text: 'Reseteaza',
                    onPressed: () {
                      AutoRouter.of(context).pushAndPopUntil(
                        const ResetPasswordSuccessfullyRoute(),
                        predicate: (route) => false,
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
