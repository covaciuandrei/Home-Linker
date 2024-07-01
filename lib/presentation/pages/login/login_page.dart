import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/login/login_cubit.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_text_button.dart';
import 'package:homelinker/presentation/widgets/main_text_field.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool isButtonAvailable = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LoginCubit>(context).loadPage();
    });

    emailTextController
        .addListener(() => BlocProvider.of<LoginCubit>(context).checkEmailValidity(emailTextController.text));
    passwordTextController
        .addListener(() => BlocProvider.of<LoginCubit>(context).checkPasswordValidity(passwordTextController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, BaseState>(
      listener: (context, state) {
        if (state is NavigateToSignupState) {
          AutoRouter.of(context).replace(const SignupRoute());
        } else if (state is NavigateToIntroductiveState) {
          AutoRouter.of(context).replace(const SignupRoute());
        } else if (state is LoggedInSuccessfullyState) {
          AutoRouter.of(context).pushAndPopUntil(
            const HomeRoute(),
            predicate: (route) => false,
          );
        } else if (state is SomethingWentWrongState) {
          AutoRouter.of(context).popForced();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong, please try again.'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is RightInputState) {
          isButtonAvailable = true;
        } else if (state is InputsErrorState) {
          isButtonAvailable = false;
        }

        return LoadingScreen<LoginCubit>(
          loading: state is PendingState,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: BlueShadowBackground(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2,
                        ),
                        child: Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.225,
                            ),
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
                      ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          // height: MediaQuery.of(context).size.height * 0.5,
                          // color: Colors.red,
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 60),
                                  child: Column(
                                    children: [
                                      // const SizedBox(height: 16),
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
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: MainTextButton(
                                          text: AppLocalizations.of(context).forgotPassword,
                                          onPressed: () => AutoRouter.of(context).push(
                                            const ForgotPasswordRoute(),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 20),
                                      MainButton(
                                        width: 150,
                                        text: AppLocalizations.of(context).login,
                                        isEnabled: isButtonAvailable,
                                        onPressed: () {
                                          showVerificationDialog(
                                            context: context,
                                            email: emailTextController.text,
                                            password: passwordTextController.text,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: MainTextButton(
                                  text: AppLocalizations.of(context).createNewAccount,
                                  onPressed: () => BlocProvider.of<LoginCubit>(context).goToSignup(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showVerificationDialog({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    final TextEditingController controller = TextEditingController();
    String message = '';
    Color textColor = Colors.grey;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Enter Code received on email"),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        message,
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ),
                    TextField(controller: controller),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Confirm"),
                  onPressed: () async {
                    final wasCodeOk = await BlocProvider.of<LoginCubit>(context).verifyCodeAndLogin(
                      context: context,
                      email: email,
                      password: password,
                      code: controller.text,
                    );
                    if (!wasCodeOk) {
                      print('dsaojdjskahkjdhsakjdhsa');
                      setState(() {
                        textColor = Colors.red;
                        message = "Code/email address is wrong, please try again.";
                      });
                    }
                  },
                ),
                TextButton(
                  child: const Text("Send code again"),
                  onPressed: () async {
                    final wasEmailSent = await BlocProvider.of<LoginCubit>(context).sendEmail(email: email);
                    if (wasEmailSent) {
                      setState(() {
                        textColor = Colors.green;
                        message = "Mail Sent Successfully";
                      });
                    } else {
                      setState(() {
                        textColor = Colors.red;
                        message = "Mail not sent, please try again.";
                      });
                    }
                  },
                )
              ],
            );
          },
        );
      },
    );
  }
}
