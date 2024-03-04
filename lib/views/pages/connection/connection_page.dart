import 'package:flutter/material.dart';

import '../../../core/constants/images.dart';
import '../../../main.dart';
import '../signin/signin_page.dart';
import '../config_selection/select_config_page.dart';

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // change statusbar color
    MyApp.changeColor();
    // theme
    var textTheme = Theme.of(context).textTheme;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var cardColor = Theme.of(context).cardColor;
    // device size
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      drawer: Drawer(
        backgroundColor: scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading:
                  const Icon(Icons.arrow_back_rounded, color: Colors.white),
              title: Text('Sign In', style: textTheme.labelMedium),
              onTap: () {
                var route =
                    MaterialPageRoute(builder: (context) => const SignInPage());
                Navigator.push(context, route);
              },
            ),
            const Divider(color: Colors.white),
            ListTile(
              leading:
                  const Icon(Icons.arrow_back_rounded, color: Colors.white),
              title: Text('Select Config', style: textTheme.labelMedium),
              onTap: () {
                var route = MaterialPageRoute(
                    builder: (context) => const ConfigSelectionPage());
                Navigator.push(context, route);
              },
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: height * 0.04),
            // config selection button
            GestureDetector(
              onTap: () {
                // go to config selection page
                var route = MaterialPageRoute(
                    builder: (context) => const ConfigSelectionPage());
                Navigator.push(context, route);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 18.0),
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
                          Images.franceImage,
                          width: 48.0,
                        ),
                        const SizedBox(width: 15.0),
                        Text(
                          'فرانسه',
                          style: textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const Text('110ms')
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.06),
            // show state connection
            Text('متصل', style: textTheme.labelMedium),
            // power button
            Container(
              margin: const EdgeInsets.only(top: 18.0, bottom: 12.0),
              padding: const EdgeInsets.all(65.0),
              decoration: BoxDecoration(
                color: cardColor,
                shape: BoxShape.circle,
                border: Border.all(color: primaryColor, width: 8.0),
              ),
              child: Image.asset('assets/icons/power.png', width: 80.0),
            ),
            // connection duration
            const Text('00:42:54', style: TextStyle(fontSize: 30.0)),
            // speed test
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // upload
                Row(
                  children: [
                    Column(
                      children: [
                        Text('آپلود', style: textTheme.labelMedium),
                        const SizedBox(height: 3.0),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: '35.8 ',
                                    style: TextStyle(fontSize: 17.0)),
                                TextSpan(
                                    text: 'KB/s',
                                    style: TextStyle(fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15.0),
                    Image.asset('assets/icons/upload.png', width: 35.0),
                  ],
                ),
                // download
                Row(
                  children: [
                    Column(
                      children: [
                        Text('دانلود', style: textTheme.labelMedium),
                        const SizedBox(height: 3.0),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: '55.6 ',
                                    style: TextStyle(fontSize: 17.0)),
                                TextSpan(
                                    text: 'KB/s',
                                    style: TextStyle(fontSize: 12.0)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15.0),
                    Image.asset('assets/icons/upload.png', width: 35.0),
                  ],
                ),
              ],
            ),
            SizedBox(height: height * 0.07),
            // package size
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('حجم باقی مانده: 80 درصد'),
                    Text('30 روزه / 24 روز باقی مانده'),
                  ],
                ),
                const SizedBox(height: 10.0),
                Stack(
                  children: [
                    Container(
                      width: width,
                      height: 16.0,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    Container(
                      width: width * 0.80,
                      height: 16.0,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
