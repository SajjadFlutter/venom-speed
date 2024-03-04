import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs_data/configs_data_list.dart';
import '../../../../controllers/index_controller.dart';

class ConfigItem extends StatelessWidget {
  const ConfigItem({
    super.key,
    required this.index,
    required this.indexController,
    required this.cardColor,
    required this.primaryColor,
    required this.textTheme,
  });

  final int index;
  final IndexController indexController;
  final Color cardColor;
  final Color primaryColor;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        indexController.changeIndex(index);
      },
      child: Obx(
        () => Container(
          margin: EdgeInsets.only(
            top: index == 0 ? 25.0 : 0.0,
            bottom: index == configsDataList.length - 1 ? 25.0 : 0.0,
            right: 20.0,
            left: 20.0,
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              width: 1.5,
              color: index == indexController.selectedIndex.toInt()
                  ? primaryColor
                  : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    configsDataList[index].countryImage!,
                    width: 48.0,
                  ),
                  const SizedBox(width: 15.0),
                  Column(
                    children: [
                      Text(
                        configsDataList[index].countryName!,
                        style: textTheme.labelMedium,
                      ),
                      const SizedBox(height: 10.0),
                      Text(configsDataList[index].ping!),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5,
                    color: index == indexController.selectedIndex.toInt()
                        ? primaryColor
                        : Colors.grey.shade100,
                  ),
                ),
                child: Container(
                  width: 13.0,
                  height: 13.0,
                  decoration: BoxDecoration(
                    color: index == indexController.selectedIndex.toInt()
                        ? primaryColor
                        : null,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
