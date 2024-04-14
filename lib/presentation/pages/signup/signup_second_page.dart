import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/signup/signup_cubit.dart';
import 'package:homelinker/models/enums/account_type.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/dropdown_picker.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_text_button.dart';
import 'package:homelinker/presentation/widgets/main_text_field.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class SignupSecondPage extends StatefulWidget {
  const SignupSecondPage({
    super.key,
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  State<SignupSecondPage> createState() => _SignupSecondPageState();
}

class _SignupSecondPageState extends State<SignupSecondPage> {
  final phoneTextController = TextEditingController();
  final nameTextController = TextEditingController();

  bool isButtonAvailable = false;
  String accountType = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadPage();
    phoneTextController.addListener(() => BlocProvider.of<SignupCubit>(context)
        .checkPhoneValidity(phoneTextController.text));
    nameTextController.addListener(() => BlocProvider.of<SignupCubit>(context)
        .checkNameValidity(nameTextController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, BaseState>(
      listener: (context, state) {
        if (state is SignUpSuccessfullyState) {
          AutoRouter.of(context).replace(const SignUpSuccessfullyRoute());
        }
      },
      builder: (context, state) {
        if (state is RightInputState) {
          isButtonAvailable = true;
        } else if (state is InputErrorState) {
          isButtonAvailable = false;
        }
        return LoadingScreen(
          loading: state is PendingState,
          child: Scaffold(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  MainTextField(
                                    textController: nameTextController,
                                    placeholder: 'Name',
                                  ),
                                  const SizedBox(height: 16),
                                  MainTextField(
                                    textController: phoneTextController,
                                    placeholder: 'Phone number',
                                  ),
                                  const SizedBox(height: 16),
                                  DropdownPicker(
                                    onValueChanged: (value) {
                                      accountType = value;
                                    },
                                    width: MediaQuery.of(context).size.width,
                                    list: [
                                      AccountType.propertyOwner.name,
                                      AccountType.client.name,
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  MainButton(
                                    isEnabled: isButtonAvailable,
                                    onPressed: () {
                                      BlocProvider.of<SignupCubit>(context)
                                          .createAccount(
                                        accountType:
                                            getAccountType(accountType),
                                        name: nameTextController.text,
                                        phoneNumber: phoneTextController.text,
                                        email: widget.email,
                                        password: widget.password,
                                      );
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
                              onPressed: () =>
                                  BlocProvider.of<SignupCubit>(context)
                                      .goToLogin(),
                            ),
                          ),
                        ],
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
