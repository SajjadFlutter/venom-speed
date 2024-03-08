import 'package:flutter/material.dart';
import 'package:venom_speed/configs_data/configs_data_list.dart';

import '../../../config_selection/view/config_selection_page.dart';
import '../connection_page.dart';

class SelectedConfig extends StatelessWidget {
  const SelectedConfig({
    super.key,
    required this.cardColor,
    required this.textTheme,
  });

  final Color cardColor;
  final TextTheme textTheme;

  static bool firsTime = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // go to config selection page
        if (firsTime) {
          ConfigSelectionPage.pageController = PageController(initialPage: 0);
          mainConfigsDataList = serverConfigsDataList;
        } else {
          ConfigSelectionPage.pageController = PageController(initialPage: 1);
          mainConfigsDataList = manualConfigsDataList;
        }
        var route = MaterialPageRoute(
            builder: (context) => const ConfigSelectionPage());
        Navigator.push(context, route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
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
            Text(ConnectionPage.selectedConfig.ping!)
          ],
        ),
      ),
    );
  }
}