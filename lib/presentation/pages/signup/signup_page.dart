import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/signup/signup_cubit.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_text_button.dart';
import 'package:homelinker/presentation/widgets/main_text_field.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repeatPasswordTextController = TextEditingController();
  bool isButtonAvailable = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadPage();
    emailTextController
        .addListener(() => BlocProvider.of<SignupCubit>(context).checkEmailValidity(emailTextController.text));
    passwordTextController.addListener(() => BlocProvider.of<SignupCubit>(context).checkPasswordValidity(
          passwordTextController.text,
          repeatPasswordTextController.text,
        ));
    repeatPasswordTextController.addListener(() => BlocProvider.of<SignupCubit>(context).checkPasswordValidity(
          passwordTextController.text,
          repeatPasswordTextController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, BaseState>(
      listener: (context, state) {
        if (state is SignUpSuccessfullyState) {
          AutoRouter.of(context).replace(const SignUpSuccessfullyRoute());
        } else if (state is NavigateToLoginState) {
          AutoRouter.of(context).replace(const LoginRoute());
        } else if (state is SecondSignupState) {
          AutoRouter.of(context).push(
            SignupSecondRoute(
              email: emailTextController.text,
              password: passwordTextController.text,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is RightInputState) {
          isButtonAvailable = true;
        } else if (state is InputErrorState) {
          isButtonAvailable = false;
        }
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
                                  placeholder: AppLocalizations.of(context).email,
                                ),
                                const SizedBox(height: 16),
                                MainTextField(
                                  textController: passwordTextController,
                                  placeholder: AppLocalizations.of(context).password,
                                  isPassword: true,
                                ),
                                const SizedBox(height: 16),
                                MainTextField(
                                  textController: repeatPasswordTextController,
                                  placeholder: AppLocalizations.of(context).repeatPassword,
                                  isPassword: true,
                                ),
                                const SizedBox(height: 20),
                                MainButton(
                                  isEnabled: isButtonAvailable,
                                  onPressed: () {
                                    BlocProvider.of<SignupCubit>(context).goToSecondSignupPage();
                                  },
                                  text: AppLocalizations.of(context).signup,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: MainTextButton(
                            text: AppLocalizations.of(context).alreadyHaveAccount,
                            onPressed: () => BlocProvider.of<SignupCubit>(context).goToLogin(),
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
