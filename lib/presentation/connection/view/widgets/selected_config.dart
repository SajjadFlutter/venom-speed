import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config_selection/view/select_config_page.dart';
import '../connection_page.dart';

class SelectedConfig extends StatelessWidget {
  const SelectedConfig({
    super.key,
    required this.primaryColor,
    required this.secondaryHeaderColor,
    required this.textTheme,
    required this.ping,
  });

  final Color primaryColor;
  final Color secondaryHeaderColor;
  final TextTheme textTheme;
  final String ping;

  static bool isFirstTime = true;
  static String configType = '';

  @override
  Widget build(BuildContext context) {
    getConfigType();

    return GestureDetector(
      onTap: () {
        // go to config selection page
        if (isFirstTime) {
          SelectConfigPage.pageController = PageController(initialPage: 0);
        } else {
          SelectConfigPage.pageController = PageController(initialPage: 1);
        }
        var route =
            MaterialPageRoute(builder: (context) => const SelectConfigPage());
        Navigator.push(context, route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
        decoration: BoxDecoration(
          color: secondaryHeaderColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SelectedConfig.configType == 'server'
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: ConnectionPage.selectedConfig.countryImage!,
                          width: 48.0,
                          height: 48.0,
                          placeholder: (context, url) => SizedBox(
                              width: 30.0,
                              child: CircularProgressIndicator(
                                  color: primaryColor)),
                          errorWidget: (context, url, error) => Image.asset(
                            ConnectionPage.selectedConfig.countryImage!,
                            width: 38.0,
                          ),
                        ),
                      )
                    : Image.asset(
                        ConnectionPage.selectedConfig.countryImage!,
                        width: 48.0,
                      ),
                const SizedBox(width: 15.0),
                Text(
                  ConnectionPage.selectedConfig.countryName!,
                  style: textTheme.labelMedium,
                ),
              ],
            ),
            Directionality(textDirection: TextDirection.ltr, child: Text(ping)),
          ],
        ),
      ),
    );
  }

  void getConfigType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SelectedConfig.configType = prefs.getString('configType') ?? '';
  }
}
