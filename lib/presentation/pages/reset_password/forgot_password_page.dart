import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_text_field.dart';

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: BlueShadowBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Va rugam sa va introduceti mailul asociat contului pentru a va putea trimite pe mail instructiunile necesare resetarii parolei.',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              MainTextField(
                textController: emailTextController,
                placeholder: 'Email',
              ),
              const SizedBox(height: 40),
              MainButton(
                text: 'Trimite',
                onPressed: () {
                  AutoRouter.of(context).push(const ResetPasswordRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
