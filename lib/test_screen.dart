import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shared Preferences Example')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                // زمان ورود کاربر را ثبت کنید
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt(
                    'lastLoginTime', DateTime.now().millisecondsSinceEpoch);
              },
              child: Text('Log In'),
            ),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int? lastLoginTime = prefs.getInt('lastLoginTime');
                if (lastLoginTime != null) {
                  int timeDifference =
                      DateTime.now().millisecondsSinceEpoch - lastLoginTime;
                  int secondsOutsideApp = (timeDifference / 1000).round();
                  print(
                      'User was outside the app for $secondsOutsideApp seconds');
                } else {
                  print('User has not logged in before');
                }
              },
              child: const Text('Check Time Outside App'),
            ),
          ],
        ),
      ),
    );
  }
}
