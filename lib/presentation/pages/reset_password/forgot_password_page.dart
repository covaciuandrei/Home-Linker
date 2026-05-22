import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/reset_password/forgot_password_cubit.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_text_field.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget implements AutoRouteWrapper {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (context) => getIt<ForgotPasswordCubit>(),
      child: this,
    );
  }
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void initState() {
    BlocProvider.of<ForgotPasswordCubit>(context).loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();

    return BlocConsumer<ForgotPasswordCubit, BaseState>(listener: (context, state) {
      if (state is EmailSentSuccessfullyState) {
        AutoRouter.of(context).push(const EmailSentSuccessfullyRoute());
      }
    }, builder: (context, state) {
      return LoadingScreen(
        loading: state is PendingState,
        child: Scaffold(
          appBar: AppBar(),
          body: BlueShadowBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppLocalizations.of(context).emailNeededForValidatingAccount,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  MainTextField(
                    textController: emailTextController,
                    placeholder: AppLocalizations.of(context).email,
                  ),
                  const SizedBox(height: 40),
                  MainButton(
                    text: AppLocalizations.of(context).send,
                    onPressed: () {
                      BlocProvider.of<ForgotPasswordCubit>(context).resetPassword(email: emailTextController.text);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
