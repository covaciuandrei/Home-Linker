import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingScreen<T extends Cubit> extends StatelessWidget {
  final Widget child;
  final bool loading;

  const LoadingScreen({
    super.key,
    required this.child,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        if (loading)
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.5),
            child: const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          ),
      ],
    );
  }
}
