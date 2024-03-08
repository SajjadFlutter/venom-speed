import 'package:flutter_v2ray/flutter_v2ray.dart';
import 'package:venom_speed/presentation/connection/view/connection_page.dart';

class V2rayProvider {
  FlutterV2ray? flutterV2ray;
  V2RayURL? v2rayURL;

  String configLink = '';
  String status = '';
  String ping = '';

  dynamic initV2ray({required String config}) async {
    flutterV2ray = FlutterV2ray(onStatusChanged: (status) {
      this.status = status.state;
    });

    await flutterV2ray!.initializeV2Ray();

    v2rayURL = FlutterV2ray.parseFromURL(config);
    // print(config);
  }

  Future<void> getPnig() async {
    await flutterV2ray!.getConnectedServerDelay().then((value) {
      ping = '$value ms';
      return ping;
    });
  }

  Future<void> connect() async {
    configLink = ConnectionPage.selectedConfig.config!;

    if (configLink != '') {
      initV2ray(config: configLink);
    }
    if (await flutterV2ray!.requestPermission()) {
      await flutterV2ray!.startV2Ray(
        remark: v2rayURL!.remark,
        config: v2rayURL!.getFullConfiguration(),
        blockedApps: null,
        bypassSubnets: null,
        proxyOnly: false,
      );
      // print(configController.text);
    }
  }

  Future<void> disconnect() async {
    status = '';
    ping = '';
    await flutterV2ray!.stopV2Ray();
  }
}
