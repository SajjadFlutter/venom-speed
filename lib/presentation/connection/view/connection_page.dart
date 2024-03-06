import 'package:flutter/material.dart';
import 'package:ripple_wave/ripple_wave.dart';

import '../../../../core/constants/images.dart';
import '../../../../main.dart';
import '../../config_selection/view/config_selection_page.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

late AnimationController animationController;

void start() {
  animationController.repeat();
}

void stop() {
  animationController.stop();
}

class _ConnectionPageState extends State<ConnectionPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    super.initState();
  }

  bool isLoading = false;
  bool isComplete = false;
  bool isClicked = false;

  loadingState() {
    isLoading = true;
    setState(() {});
  }

  completeState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        isLoading = false;
        isComplete = true;
        setState(() {});
      },
    );
  }

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
    // controller
    // final VisibleController visibleController = Get.put(VisibleController());

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      drawer: Drawer(
        backgroundColor: scaffoldBackgroundColor,
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
            Text(
                isLoading == true
                    ? 'در حال اتصال...'
                    : isComplete == true
                        ? 'متصل'
                        : 'عدم اتصال',
                style: textTheme.labelMedium),
            // power button
            Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: isLoading,
                  child: SizedBox(
                    width: 300,
                    child: RippleWave(
                      animationController: animationController,
                      repeat: true,
                      color: Colors.white,
                      childTween: Tween(begin: 1.0, end: 1.0),
                      child: Container(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    loadingState();
                    completeState();

                    if (isComplete == true) {
                      isComplete = false;
                      setState(() {});
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    padding: const EdgeInsets.all(60.0),
                    decoration: BoxDecoration(
                      color: cardColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: isLoading == true
                              ? Colors.transparent
                              : isLoading == false && isComplete == true
                                  ? const Color(0xFF178F1D)
                                  : primaryColor,
                          width: 8.0),
                    ),
                    child: Image.asset(
                      Images.power,
                      width: 80.0,
                      color: isComplete == true
                          ? const Color(0xFF178F1D)
                          : primaryColor,
                    ),
                  ),
                ),
              ],
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
