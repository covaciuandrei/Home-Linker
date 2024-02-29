import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/signup/signup_cubit.dart';
import 'package:homelinker/presentation/models/blue_shadow_background.dart';
import 'package:homelinker/presentation/models/main_button.dart';
import 'package:homelinker/presentation/models/main_text_button.dart';
import 'package:homelinker/presentation/models/main_text_field.dart';
import 'package:homelinker/presentation/models/svg_icon.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    final repeatTextController = TextEditingController();

    return BlocConsumer<SignupCubit, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: BlueShadowBackground(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 130),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SvgIcon(
                            iconName: 'home',
                            color: Colors.lightBlue,
                            size: 80,
                          ),
                          Text(
                            AppLocalizations.of(context).appTitle,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 36,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                MainTextField(
                                  textController: emailTextController,
                                  placeholder: 'Email',
                                ),
                                const SizedBox(height: 16),
                                MainTextField(
                                  textController: passwordTextController,
                                  placeholder: 'Password',
                                ),
                                const SizedBox(height: 16),
                                MainTextField(
                                  textController: repeatTextController,
                                  placeholder: 'Repeat Password',
                                ),
                                const SizedBox(height: 20),
                                MainButton(
                                  onPressed: () {
                                    AutoRouter.of(context)
                                        .push(const SignUpSuccessfullyRoute());
                                  },
                                  text: 'Sign Up',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: MainTextButton(
                            text: "Already have an account? Log in",
                            onPressed: () {
                              AutoRouter.of(context)
                                  .replace(const LoginRoute());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
