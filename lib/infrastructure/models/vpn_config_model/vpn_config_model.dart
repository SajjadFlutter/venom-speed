import 'package:hive/hive.dart';

part 'vpn_config_model.g.dart';

@HiveType(typeId: 0)
class VPNConfigModel {
  @HiveField(0)
  final String? countryImage;
  @HiveField(1)
  final String? countryName;
  @HiveField(2)
  final String? config;
  @HiveField(3)
  final String? ping;
  @HiveField(4)
  final bool? isSelected;

  VPNConfigModel({
    required this.countryImage,
    required this.countryName,
    required this.config,
    required this.ping,
    required this.isSelected,
  });
}
