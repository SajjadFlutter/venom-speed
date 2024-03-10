// ignore_for_file: use_build_context_synchronously

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/images.dart';
import '../../../../main.dart';
import '../../../infrastructure/models/vpn_config_model/vpn_config_model.dart';
import '../bloc/timer_cubit.dart';
import 'widgets/selected_config.dart';
import 'widgets/speed_test.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  static VPNConfigModel selectedConfig = VPNConfigModel(
    countryImage: Images.franceImage,
    countryName: 'فرانسه',
    config: 'config',
    ping: '110ms',
    isSelected: false,
  );

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  String configLink = '';

  FlutterV2ray? flutterV2ray;
  var v2rayStatus = ValueNotifier<V2RayStatus>(V2RayStatus());
  V2RayURL? v2rayURL;

  String status = 'DISCONNECTED';
  String ping = '110ms';

  Future<void> initV2ray(String config) async {
    flutterV2ray = FlutterV2ray(onStatusChanged: (status) {
      setState(() {
        this.status = status.state;
        v2rayStatus.value = status;
        print(status.state);
      });
    });

    await flutterV2ray!.initializeV2Ray();

    v2rayURL = FlutterV2ray.parseFromURL(config);
  }

  Future<void> getPnig() async {
    await flutterV2ray!.getConnectedServerDelay().then((value) {
      setState(() {
        ping = '${value}ms';
      });
    });
  }

  Future<void> connect() async {
    configLink = ConnectionPage.selectedConfig.config!;
    status = 'LOADING';
    setState(() {});

    await Future.delayed(const Duration(seconds: 3));

    if (configLink != '') {
      initV2ray(configLink);
    }

    // ignore: unnecessary_null_comparison
    if (await flutterV2ray!.requestPermission() != null) {
      if (await flutterV2ray!.requestPermission()) {
        await flutterV2ray!.startV2Ray(
          remark: v2rayURL!.remark,
          config: v2rayURL!.getFullConfiguration(),
          blockedApps: null,
          bypassSubnets: null,
          proxyOnly: false,
        );
        // start time
        BlocProvider.of<TimerCubit>(context).start();
      }
    }

    print(flutterV2ray);
  }

  Future<void> disconnect() async {
    // ignore: unnecessary_null_comparison
    if (flutterV2ray!.stopV2Ray() != null) {
      setState(() {
        status = '';
        ping = '';
      });
      await flutterV2ray!.stopV2Ray();

      BlocProvider.of<TimerCubit>(context).reset();
    }
  }

  @override
  void initState() {
    super.initState();
    getSelectedConfigFromHive();
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
            SelectedConfig(
              cardColor: cardColor,
              textTheme: textTheme,
              ping: ping,
            ),
            SizedBox(height: height * 0.06),
            // show state connection
            Text(
                status == 'LOADING'
                    ? 'در حال اتصال...'
                    : status == 'CONNECTED'
                        ? 'متصل'
                        : 'عدم اتصال',
                style: textTheme.labelMedium),
            // power button
            AvatarGlow(
              glowColor: Colors.white,
              duration: const Duration(milliseconds: 1800),
              repeat: true,
              glowRadiusFactor: 0.3,
              glowCount: 3,
              animate: status == 'LOADING',
              child: GestureDetector(
                onTap: () {
                  if (status == 'DISCONNECTED') {
                    connect();
                  } else if (status == 'CONNECTED') {
                    disconnect();
                  }
                },
                child: Container(
                  width: 216.0,
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  padding: const EdgeInsets.all(60.0),
                  decoration: BoxDecoration(
                    color: cardColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: status == 'LOADING'
                            ? Colors.transparent
                            : status == 'CONNECTED'
                                ? const Color(0xFF178F1D)
                                : primaryColor,
                        width: 8.0),
                  ),
                  child: Image.asset(
                    Images.power,
                    width: 80.0,
                    color: status == 'CONNECTED'
                        ? const Color(0xFF178F1D)
                        : primaryColor,
                  ),
                ),
              ),
            ),
            // connection duration
            BlocBuilder<TimerCubit, String>(
              builder: (context, state) {
                return Text(state, style: const TextStyle(fontSize: 30.0));
              },
            ),
            SizedBox(height: height * 0.05),
            // speed test
            SpeedTest(
              textTheme: textTheme,
              uploadValue: v2rayStatus.value.upload,
              downloadValue: v2rayStatus.value.download,
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

  void getSelectedConfigFromHive() {
    Hive.box<VPNConfigModel>('VPNConfigModel_Box').values.forEach(
      (model) {
        if (model.isSelected == true) {
          ConnectionPage.selectedConfig = model;
        }
      },
    );
  }

  // Future<void> setSignInStatus(int lastExitTime) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('lastExitTime', lastExitTime);
  // }
  // Future<int> getSignInStatus() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt('lastExitTime') ?? 0;
  // }
  // void _checkSignInStatus() async {
  //   int isSignIn = await getSignInStatus();
  // if (isSignIn) {
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
  //     builder: (context) => const ConnectionPage(),
  //   ));
  // } else {
  //   return;
  // }
  // }
}
