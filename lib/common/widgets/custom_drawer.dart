import 'package:flutter/material.dart';

import '../../core/constants/images.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.scaffoldBackgroundColor,
    required this.height,
    required this.secondaryHeaderColor,
    required this.textTheme,
  });

  final Color scaffoldBackgroundColor;
  final double height;
  final Color secondaryHeaderColor;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: scaffoldBackgroundColor,
      child: Column(
        children: [
          SizedBox(height: height * 0.14),
          // logo and title
          Image.asset(
            Images.logo,
            width: 90.0,
          ),
          SizedBox(height: height * 0.03),
          // Title
          const Text(
            'Venom Speed',
            style: TextStyle(
              fontFamily: 'lora',
              fontSize: 26.0,
              color: Color(0xff697dd1),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.1),
          // news and updates
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: secondaryHeaderColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.update_rounded,
                size: 28.0,
                color: Colors.grey.shade100,
              ),
            ),
            title: Text('اخبار و بروزرسانی ها', style: textTheme.labelMedium),
            onTap: () async {
              // final Uri url = Uri.parse('https://t.me/application_support_1');
              // if (!await launchUrl(url,
              //     mode: LaunchMode.externalApplication)) {
              //   throw 'Could not launch $url';
              // }
            },
          ),
          // subscription renewal
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: secondaryHeaderColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.grey.shade100,
              ),
            ),
            title: Text('تمدید اشتراک', style: textTheme.labelMedium),
            onTap: () async {
              // final Uri url =
              //     Uri.parse('https://eitaa.com/application_support_1');
              // if (!await launchUrl(url,
              //     mode: LaunchMode.externalApplication)) {
              //   throw 'Could not launch $url';
              // }
            },
          ),
          // Support
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: secondaryHeaderColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.headset_mic_rounded,
                color: Colors.grey.shade100,
              ),
            ),
            title: Text('پشتیبانی', style: textTheme.labelMedium),
            onTap: () async {
              // final Uri url =
              //     Uri.parse('https://eitaa.com/application_support_1');
              // if (!await launchUrl(url,
              //     mode: LaunchMode.externalApplication)) {
              //   throw 'Could not launch $url';
              // }
            },
          ),
          SizedBox(height: height * 0.03),
          // Exit
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(9.0),
              decoration: BoxDecoration(
                color: secondaryHeaderColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.exit_to_app_rounded,
                color: Colors.grey.shade100,
                size: 26.0,
              ),
            ),
            title: Text('خروج از برنامه', style: textTheme.labelMedium),
            onTap: () async {
              // final Uri url =
              //     Uri.parse('https://eitaa.com/application_support_1');
              // if (!await launchUrl(url,
              //     mode: LaunchMode.externalApplication)) {
              //   throw 'Could not launch $url';
              // }
            },
          ),
        ],
      ),
    );
  }
}
