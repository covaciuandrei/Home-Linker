import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/profile/profile_cubit.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profilePicture;

  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, BaseState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ImageUploadedSuccessfullyState) {
            _profilePicture = state.image;
          }
          return LoadingScreen(
            loading: state is PendingState,
            child: Scaffold(
              appBar: MainAppBar(title: AppLocalizations.of(context).profile),
              body: BlueShadowBackground(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      _profilePicture == null
                          ? const SvgIcon(iconName: 'avatar', size: 200)
                          : CircularImage(imageFile: _profilePicture!),
                      IconButton(
                        icon: const Icon(
                          Icons.edit_square,
                          color: Colors.lightBlue,
                          size: 30,
                        ),
                        onPressed: () async {
                          await BlocProvider.of<ProfileCubit>(context).changePicture();
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Covaciu Andrei',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromRGBO(7, 42, 108, 1),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              AppLocalizations.of(context).email,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'covaciuandrei21@gmail.com',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color.fromRGBO(7, 42, 108, 1),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              AppLocalizations.of(context).phoneNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '+40 765 707 000',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color.fromRGBO(7, 42, 108, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          'Version 1.0 @ 2023',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
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

class CircularImage extends StatelessWidget {
  final File imageFile; // The image file to be displayed

  const CircularImage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Image.file(
          imageFile,
          height: 200, // The height of the circle
          width: 200, // The width of the circle
          fit: BoxFit.cover, // This ensures the image fills the circle
        ),
      ),
    );
  }
}
