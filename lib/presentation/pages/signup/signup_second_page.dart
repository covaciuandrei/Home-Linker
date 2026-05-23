import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/app_theme.dart';
import 'package:homelinker/core/injection.dart';
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
class SignupSecondPage extends StatefulWidget implements AutoRouteWrapper {
  const SignupSecondPage({
    super.key,
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  State<SignupSecondPage> createState() => _SignupSecondPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SignupCubit>(
      create: (context) => getIt<SignupCubit>(),
      child: this,
    );
  }
}

class _SignupSecondPageState extends State<SignupSecondPage> with SingleTickerProviderStateMixin {
  final phoneTextController = TextEditingController();
  final nameTextController = TextEditingController();

  bool isButtonAvailable = false;
  String accountType = '';

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));

    BlocProvider.of<SignupCubit>(context).loadPage();
    _animController.forward();

    phoneTextController
        .addListener(() => BlocProvider.of<SignupCubit>(context).checkPhoneValidity(phoneTextController.text));
    nameTextController
        .addListener(() => BlocProvider.of<SignupCubit>(context).checkNameValidity(nameTextController.text));
  }

  @override
  void dispose() {
    _animController.dispose();
    phoneTextController.dispose();
    nameTextController.dispose();
    super.dispose();
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
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: BlueShadowBackground(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                      // ── Logo ─────────────────────────────────
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.8),
                                    Colors.white,
                                  ],
                                ).createShader(bounds);
                              },
                              child: const SvgIcon(
                                iconName: 'home',
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppLocalizations.of(context).appTitle,
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // ── Form ─────────────────────────────────
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                MainTextField(
                                  textController: nameTextController,
                                  placeholder: AppLocalizations.of(context).name,
                                  prefixIcon: Icons.person_outline_rounded,
                                ),
                                const SizedBox(height: 16),
                                MainTextField(
                                  textController: phoneTextController,
                                  placeholder: AppLocalizations.of(context).phoneNumber,
                                  prefixIcon: Icons.phone_outlined,
                                  keyboardType: TextInputType.phone,
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
                                const SizedBox(height: 28),
                                MainButton(
                                  width: 200,
                                  isEnabled: isButtonAvailable,
                                  color: Colors.white,
                                  textColor: AppColors.primary,
                                  onPressed: () {
                                    BlocProvider.of<SignupCubit>(context).createAccount(
                                      accountType: getAccountType(accountType),
                                      name: nameTextController.text,
                                      phoneNumber: phoneTextController.text,
                                      email: widget.email,
                                      password: widget.password,
                                    );
                                  },
                                  text: AppLocalizations.of(context).signup,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),

                      MainTextButton(
                        text: AppLocalizations.of(context).alreadyHaveAccount,
                        onPressed: () => BlocProvider.of<SignupCubit>(context).goToLogin(),
                      ),
                      const SizedBox(height: 40),
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
}
