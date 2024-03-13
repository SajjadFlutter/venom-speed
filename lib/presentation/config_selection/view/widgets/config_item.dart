// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:venom_speed/presentation/config_selection/view/config_selection_page.dart';

import '../../../../common/bloc/change_selected_config_cubit.dart';
import '../../../../configs_data/configs_data_list.dart';
import '../../../../infrastructure/models/vpn_config_model/vpn_config_model.dart';
import '../../../add_config/bloc/add_config_bloc.dart';
import '../../../add_config/bloc/add_config_event.dart';
import '../../../connection/view/connection_page.dart';
import '../../../connection/view/widgets/selected_config.dart';

class ConfigItem extends StatelessWidget {
  const ConfigItem({
    super.key,
    required this.index,
    required this.secondaryHeaderColor,
    required this.primaryColor,
    required this.textTheme,
  });

  final int index;
  final Color secondaryHeaderColor;
  final Color primaryColor;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        SelectedConfig.firsTime = false;

        Hive.box<VPNConfigModel>('selectedConfig_Box').clear();

        await Hive.box<VPNConfigModel>('selectedConfig_Box').add(
          VPNConfigModel(
            countryImage: mainConfigsDataList[index].countryImage,
            countryName: mainConfigsDataList[index].countryName,
            config: mainConfigsDataList[index].config,
            ping: mainConfigsDataList[index].ping,
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
              bottom: index == mainConfigsDataList.length - 1 ? 25.0 : 0.0,
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
                    Image.asset(
                      mainConfigsDataList[index].countryImage!,
                      width: 48.0,
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      children: [
                        Text(
                          mainConfigsDataList[index].countryName!,
                          style: textTheme.labelMedium,
                        ),
                        const SizedBox(height: 10.0),
                        Text(mainConfigsDataList[index].ping!),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.5,
                          color: index == state
                              ? primaryColor
                              : Colors.grey.shade100,
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
                    // delete config item
                    Visibility(
                      visible: ConfigSelectionPage.configTitle == 'کانفیگ دستی',
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                          onTap: () async {
                            manualConfigsDataList.removeAt(index);
                            await Hive.box<VPNConfigModel>('VPNConfigModel_Box')
                                .deleteAt(index);

                            BlocProvider.of<AddConfigBloc>(context)
                                .add(AddConfigEvent());
                          },
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.grey.shade100,
                            size: 28.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
