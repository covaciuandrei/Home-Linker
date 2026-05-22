import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homelinker/assets/localization/app_localizations.dart';
import 'package:homelinker/core/injection.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/cubit/profile/profile_cubit.dart';
import 'package:homelinker/models/app_version.dart';
import 'package:homelinker/presentation/widgets/blue_shadow_background.dart';
import 'package:homelinker/presentation/widgets/loading_screen.dart';
import 'package:homelinker/presentation/widgets/main_appbar.dart';
import 'package:homelinker/presentation/widgets/svg_icon.dart';

@RoutePage()
class ProfilePage extends StatefulWidget implements AutoRouteWrapper {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => getIt<ProfileCubit>(),
      child: this,
    );
  }
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profilePicture;
  String _email = '';
  String _phoneNumber = '';
  String _fullName = '';
  AppVersion? _appVersion;

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
          if (state is ProfilePageLoadedState) {
            _profilePicture = state.profilePicture;
            _email = state.user.email;
            _phoneNumber = state.user.phone;
            _fullName = state.user.name;
            _appVersion = state.appVersion;
          } else if (state is ImageUploadedSuccessfullyState) {
            _profilePicture = state.image;
          } else if (state is ImageDeletedSuccessfullyState) {
            _profilePicture = null;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                          IconButton(
                            icon: Icon(
                              Icons.disabled_by_default_rounded,
                              color: _profilePicture == null
                                  ? const Color.fromARGB(255, 124, 112, 112)
                                  : const Color.fromARGB(255, 169, 19, 8),
                              size: 30,
                            ),
                            onPressed: _profilePicture == null
                                ? null
                                : () async {
                                    await BlocProvider.of<ProfileCubit>(context).deletePicture();
                                  },
                          ),
                        ],
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
                            Text(
                              _fullName,
                              style: const TextStyle(
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
                            Text(
                              _email,
                              style: const TextStyle(
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
                            Text(
                              _phoneNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color.fromRGBO(7, 42, 108, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          _appVersion != null
                              ? '${AppLocalizations.of(context).version} ${_appVersion!.appVersion} @ ${_appVersion!.releaseDate.year}'
                              : '',
                          style: const TextStyle(
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
  final File imageFile;

  const CircularImage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Image.file(
          imageFile,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
