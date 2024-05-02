import 'package:auto_route/auto_route.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:homelinker/core/app_router.gr.dart';
import 'package:homelinker/main.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.languages,
  });

  final List<String> languages;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        children: [
          ListTile(
            title: const Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.lightBlue,
                ),
                SizedBox(width: 10),
                Text(
                  'Settngs',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              AutoRouter.of(context).push(const SettingsRoute());
              AutoRouter.of(context).popForced();
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.lightBlue,
                ),
                SizedBox(width: 10),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              AutoRouter.of(context).push(const ProfileRoute());
              AutoRouter.of(context).popForced();
            },
          ),
          Container(
            height: 1,
            color: Colors.lightBlue,
          ),
          Container(
            // color: Colors.lightGreen,
            height: MediaQuery.of(context).size.width * 0.75,
            width: MediaQuery.of(context).size.width * 0.75,
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 40,
                    height: 40,
                    child: getFlag(languages[index]),
                  ),
                  title: Text(getLanguage(languages[index])),
                  onTap: () {
                    MyApp.of(context).setLocale(Locale.fromSubtags(languageCode: languages[index]));

                    AutoRouter.of(context).popForced(context);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget getFlag(String countryCode) {
  switch (countryCode) {
    case 'ro':
      return CountryFlag.fromCountryCode('ro');
    case 'en':
      return CountryFlag.fromCountryCode('gb');
    default:
      return CountryFlag.fromCountryCode('');
  }
}

String getLanguage(String countryCode) {
  switch (countryCode) {
    case 'ro':
      return 'Română';
    case 'en':
      return 'English';
    default:
      return '';
  }
}
