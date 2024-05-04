import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/reset_password/reset_password_cubit.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/main_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  void initState() {
    BlocProvider.of<ResetPasswordCubit>(context).loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final oldPasswordTextController = TextEditingController();
    final newPasswordTextController = TextEditingController();
    final repeatNewPasswordTextController = TextEditingController();

    return BlocConsumer<ResetPasswordCubit, BaseState>(
        listener: (context, state) {},
        builder: (context, state) {
          return LoadingScreen(
            loading: state is PendingState,
            child: Scaffold(
              appBar: AppBar(),
              body: BlueShadowBackground(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MainTextField(
                          textController: oldPasswordTextController,
                          placeholder:AppLocalizations.of(context).oldPassword,
                        ),
                        const SizedBox(height: 20),
                        MainTextField(
                          textController: newPasswordTextController,
                          placeholder:AppLocalizations.of(context).newPassword ,
                        ),
                        const SizedBox(height: 20),
                        MainTextField(
                          textController: repeatNewPasswordTextController,
                          placeholder:AppLocalizations.of(context).repeatNewPassword,
                        ),
                        const SizedBox(height: 40),
                        MainButton(
                          text:AppLocalizations.of(context).reset ,
                          onPressed: () {
                            AutoRouter.of(context).pushAndPopUntil(
                              const ResetPasswordSuccessfullyRoute(),
                              predicate: (route) => false,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
