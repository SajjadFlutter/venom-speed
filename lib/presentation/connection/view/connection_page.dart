// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/images.dart';
import '../../../../main.dart';
import '../../../common/widgets/custom_drawer.dart';
import '../../../infrastructure/models/vpn_config_model/vpn_config_model.dart';
import '../bloc/timer_cubit.dart';
import 'widgets/selected_config.dart';
import 'widgets/speed_test.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  static VPNConfigModel selectedConfig = VPNConfigModel(
    countryImage: Images.franceImage,
    countryName: 'فرانسه',
    config:
        'vless://b9ad895b-12ac-40fc-a5ac-a5b2a1285001@172.67.183.26:443?encryption=none&security=tls&sni=3k.pureboy.eu.org&type=ws&host=3k.pureboy.eu.org&path=%2F%3Fed%3D2048#%D8%B9%D8%B6%D9%88%20%D8%B4%D9%88%20%3A%20%40zibanabz',
    ping: '110ms',
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
        setConnectionStatus(status.state);
      });
    });

    await flutterV2ray!.initializeV2Ray();

    v2rayURL = FlutterV2ray.parseFromURL(config);
  }

  Future<void> getPing() async {
    if (flutterV2ray != null) {
      await flutterV2ray!.getConnectedServerDelay().then((value) {
        setState(() {
          ping = '${value}ms';
        });
      });
    }
  }

  Future<void> connect() async {
    configLink = ConnectionPage.selectedConfig.config!;
    setConfigLink(ConnectionPage.selectedConfig.config!);

    if (configLink != '') {
      initV2ray(configLink);
    }

    if (flutterV2ray != null) {
      if (await flutterV2ray!.requestPermission()) {
        await flutterV2ray!.startV2Ray(
          remark: v2rayURL!.remark,
          config: v2rayURL!.getFullConfiguration(),
          blockedApps: null,
          bypassSubnets: null,
          proxyOnly: false,
        );
        // get ping
        Timer.periodic(const Duration(seconds: 10), (Timer t) {
          getPing();
        });
        // start time
        setConnectionStartTime();
        BlocProvider.of<TimerCubit>(context).startTime();
      }
    }
  }

  Future<void> disconnect() async {
    setConnectionStatus('DISCONNECTED');
    if (flutterV2ray != null) {
      if (flutterV2ray!.stopV2Ray() != null) {
        setState(() {
          status = '';
          ping = '';
        });
        await flutterV2ray!.stopV2Ray();

        // get ping
        getPing();
      }
    }
    _checkConnectionStatus();
    BlocProvider.of<TimerCubit>(context).resetTime();
  }

  Future<void> reconnect() async {
    String configLink = await getConfigLink();
    if (configLink != '') {
      initV2ray(configLink);
      await flutterV2ray!.stopV2Ray();
    }

    if (flutterV2ray != null) {
      if (await flutterV2ray!.requestPermission()) {
        await flutterV2ray!.startV2Ray(
          remark: v2rayURL!.remark,
          config: v2rayURL!.getFullConfiguration(),
          blockedApps: null,
          bypassSubnets: null,
          proxyOnly: false,
        );

        // get ping
        Timer.periodic(const Duration(seconds: 10), (Timer t) {
          getPing();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkConnectionStatus();
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
    var secondaryHeaderColor = Theme.of(context).secondaryHeaderColor;
    // device size
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: CustomDrawer(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        height: height,
        secondaryHeaderColor: secondaryHeaderColor,
        textTheme: textTheme,
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
                  color: secondaryHeaderColor,
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
              primaryColor: primaryColor,
              secondaryHeaderColor: secondaryHeaderColor,
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
                  if (status == 'DISCONNECTED' || status == 'NO_INTERNET') {
                    checkInternetConnection();
                    // connect();
                  } else if (status == 'CONNECTED') {
                    disconnect();
                  }
                },
                child: Container(
                  width: 216.0,
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  padding: const EdgeInsets.all(60.0),
                  decoration: BoxDecoration(
                    color: secondaryHeaderColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: status == 'LOADING'
                            ? Colors.transparent
                            : status == 'CONNECTED'
                                ? const Color(0xFF178F1D)
                                : status == 'NO_INTERNET'
                                    ? const Color(0xFFD12619)
                                    : primaryColor,
                        width: 8.0),
                  ),
                  child: Image.asset(
                    Images.power,
                    width: 80.0,
                    color: status == 'CONNECTED'
                        ? const Color(0xFF178F1D)
                        : status == 'NO_INTERNET'
                            ? const Color(0xFFD12619)
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
                        color: secondaryHeaderColor,
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

  // check internet connection
  Future<void> checkInternetConnection() async {
    try {
      status = 'LOADING';
      setState(() {});
      await Future.delayed(const Duration(seconds: 4));

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // connect vpn
        connect();
      }
    } on SocketException catch (_) {
      // no internet for vpn
      setState(() {
        status = 'NO_INTERNET';
      });
    }
  }

  // selected config
  void getSelectedConfigFromHive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime == false) {
      ConnectionPage.selectedConfig =
          Hive.box<VPNConfigModel>('selectedConfig_Box').values.last;
    }
  }

  // connection time
  setConnectionStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('connectionStartTime', DateTime.now().millisecondsSinceEpoch);
  }

  // connection status
  setConnectionStatus(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('connectionStatus', status);
  }

  Future<String> getConnectionStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('connectionStatus') ?? 'DISCONNECTED';
  }

  void _checkConnectionStatus() async {
    String connectionStatus = await getConnectionStatus();
    if (connectionStatus == 'CONNECTED') {
      reconnect();
      BlocProvider.of<TimerCubit>(context).continueTime();
      setState(() {
        status = 'CONNECTED';
      });
    } else {
      BlocProvider.of<TimerCubit>(context).resetTime();
      setState(() {
        status = 'DISCONNECTED';
      });
    }
  }

  // config link
  setConfigLink(String configLink) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('configLink', configLink);
  }

  Future<String> getConfigLink() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('configLink') ?? '';
  }
}
