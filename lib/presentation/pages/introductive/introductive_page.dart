import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/introductive/introductive_cubit.dart';
import 'package:homelinker/presentation/widgets/introductive_background.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class IntroductivePage extends StatefulWidget {
  const IntroductivePage({super.key});

  @override
  State<IntroductivePage> createState() => _IntroductivePageState();
}

class _IntroductivePageState extends State<IntroductivePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<IntroductiveCubit>(context).load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IntroductiveCubit, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: IntroductiveBackground(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 125),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).welcome,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: '${AppLocalizations.of(context).to} ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: AppLocalizations.of(context).appTitle,
                              style: const TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SvgIcon(
                  iconName: 'home',
                  color: Colors.lightBlue,
                  size: 200,
                ),
                const SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      MainButton(
                        text: 'Log in',
                        width: 240,
                        height: 44,
                        onPressed: () {
                          AutoRouter.of(context).push(const LoginRoute());
                        },
                      ),
                      const SizedBox(height: 16),
                      MainButton(
                        text: 'Sign Up',
                        width: 240,
                        height: 44,
                        onPressed: () {
                          AutoRouter.of(context).push(const SignupRoute());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
