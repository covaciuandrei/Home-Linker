import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/home/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, BaseState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home Linker'),
            ),
            body: const Center(
              child: Text('Home Page'),
            ),
          );
        });
  }
}
