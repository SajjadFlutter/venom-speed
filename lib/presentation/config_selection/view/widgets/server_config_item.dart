// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/bloc/change_selected_config_cubit.dart';
import '../../../../configs_data/configs_data_list.dart';
import '../../../../core/constants/images.dart';
import '../../../../infrastructure/models/server_model/server_model.dart';
import '../../../../infrastructure/models/vpn_config_model/vpn_config_model.dart';
import '../../../connection/view/connection_page.dart';

class ServerConfigItem extends StatelessWidget {
  const ServerConfigItem({
    super.key,
    required this.index,
    required this.secondaryHeaderColor,
    required this.primaryColor,
    required this.textTheme,
    required this.serverModel,
  });

  final int index;
  final Color secondaryHeaderColor;
  final Color primaryColor;
  final TextTheme textTheme;
  final ServerModel serverModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isFirstTime', false);
        prefs.setString('configType', 'server');

        await Hive.box<VPNConfigModel>('selectedConfig_Box').add(
          VPNConfigModel(
            countryImage: serverModel.result[index].flagImage,
            countryName: serverModel.result[index].flagName,
            config: serverModel.result[index].config,
            ping: serverConfigsDataList[index].ping,
          ),
        );

        BlocProvider.of<ChangeSelectedConfigCubit>(context)
            .changeSelectedConfigEvent(index);

        var route =
            MaterialPageRoute(builder: (context) => const ConnectionPage());
        Navigator.push(context, route);
      },
      child: BlocBuilder<ChangeSelectedConfigCubit, int>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(
              top: index == 0 ? 10.0 : 0.0,
              bottom: index == serverModel.result.length - 1 ? 25.0 : 0.0,
              right: 20.0,
              left: 20.0,
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
            decoration: BoxDecoration(
              color: secondaryHeaderColor,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                width: 1.5,
                color: index == state ? primaryColor : Colors.transparent,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: serverModel.result[index].flagImage,
                        width: 48.0,
                        height: 48.0,
                        placeholder: (context, url) => SizedBox(
                            width: 15.0,
                            child:
                                CircularProgressIndicator(color: primaryColor)),
                        errorWidget: (context, url, error) => Image.asset(
                          Images.logo,
                          width: 38.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      children: [
                        Text(
                          serverModel.result[index].flagName,
                          style: textTheme.labelMedium,
                        ),
                        const SizedBox(height: 10.0),
                        Text(serverConfigsDataList[index].ping!),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1.5,
                      color:
                          index == state ? primaryColor : Colors.grey.shade100,
                    ),
                  ),
                  child: Container(
                    width: 13.0,
                    height: 13.0,
                    decoration: BoxDecoration(
                      color: index == state ? primaryColor : null,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
