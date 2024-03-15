import 'package:hive/hive.dart';

part 'vpn_config_model.g.dart';

@HiveType(typeId: 0)
class VPNConfigModel {
  @HiveField(0)
  String? countryImage;
  @HiveField(1)
  String? countryName;
  @HiveField(2)
  String? config;
  @HiveField(3)
  String? ping;

  VPNConfigModel({
    required this.countryImage,
    required this.countryName,
    required this.config,
    required this.ping,
  });
}
