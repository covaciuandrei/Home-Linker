import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/login/login_cubit.dart';
import 'package:homelinker/presentation/models/blue_shadow_background.dart';
import 'package:homelinker/presentation/models/svg_icon.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: BlueShadowBackground(
            content: Center(
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
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.white,
                                        style: BorderStyle.solid),
                                  ),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          30, 10.0, 5.0, 10.0),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.white,
                                          style: BorderStyle.solid)),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          30, 10.0, 5.0, 10.0),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Forgot password?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextButton(
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(
                                        const Size.fromWidth(150)),
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            Colors.white),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(color: Colors.lightBlue),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: TextButton(
                            child: const Text(
                              "Don't have an account? Create one",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
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
