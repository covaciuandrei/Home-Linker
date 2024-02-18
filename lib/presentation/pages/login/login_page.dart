import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/login/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: TextButton(
            child: const Text('Go back'),
            onPressed: () {
              AutoRouter.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
