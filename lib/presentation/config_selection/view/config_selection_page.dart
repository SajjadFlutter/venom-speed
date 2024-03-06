import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs_data/configs_data_list.dart';
import '../../../controllers/index_controller.dart';
import '../../../core/constants/images.dart';
import '../../add_config/view/add_config_page.dart';
import 'widgets/config_item.dart';

class ConfigSelectionPage extends StatelessWidget {
  const ConfigSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // controller
    final IndexController indexController = Get.put(IndexController());
    // theme
    var textTheme = Theme.of(context).textTheme;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      drawer: Drawer(
        backgroundColor: scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              onTap: () {
                var route = MaterialPageRoute(
                    builder: (context) => const AddConfigPage());
                Navigator.push(context, route);
              },
              leading:
                  const Icon(Icons.arrow_back_rounded, color: Colors.white),
              title: const Text(
                'افزودن کانفیگ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      // appbar
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: Text(
            'Venom Speed',
            style: TextStyle(
              fontFamily: 'lora',
              color: Colors.grey.shade300,
            ),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                height: 20.0,
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.asset(Images.menu, width: 20.0),
              ),
            ),
          ),
        ],
      ),
      // body
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            // config item
            return ConfigItem(
              index: index,
              indexController: indexController,
              cardColor: cardColor,
              primaryColor: primaryColor,
              textTheme: textTheme,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 12.0),
          itemCount: configsDataList.length,
        ),
      ),
    );
  }
}
