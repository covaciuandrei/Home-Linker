import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/presentation/widgets/main_button.dart';

class SignUpSuccessfullyPage extends StatelessWidget {
  const SignUpSuccessfullyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.lightBlue,
          ),
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Contul dvs. a fost creat cu succes. Intrati pe linkul din mailul primit pentru a va putea finaliza contul',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MainButton(
                    text: 'Gata',
                    onPressed: () {
                      AutoRouter.of(context).pushAndPopUntil(
                        const IntroductiveRoute(),
                        predicate: (route) => false,
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
