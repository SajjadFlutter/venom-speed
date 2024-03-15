import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../configs_data/configs_data_list.dart';
import '../../../../infrastructure/models/vpn_config_model/vpn_config_model.dart';
import '../../../add_config/bloc/add_config_bloc.dart';
import '../../../add_config/bloc/add_config_state.dart';
import '../../../add_config/view/add_config_page.dart';
import 'manual_config_item.dart';

class ManualConfigsListWidget extends StatelessWidget {
  const ManualConfigsListWidget({
    super.key,
    required this.secondaryHeaderColor,
    required this.primaryColor,
    required this.textTheme,
  });

  final Color secondaryHeaderColor;
  final Color primaryColor;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    // get Manual Configs from Hive
    getManualConfigsFromHive();

    return Scaffold(
      body: BlocBuilder<AddConfigBloc, AddConfigState>(
        builder: (context, state) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ManualConfigItem(
                index: index,
                secondaryHeaderColor: secondaryHeaderColor,
                primaryColor: primaryColor,
                textTheme: textTheme,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemCount: manualConfigsDataList.length,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
        ),
        onPressed: () {
          var route =
              MaterialPageRoute(builder: (context) => const AddConfigPage());
          Navigator.push(context, route);
        },
        child: Icon(
          Icons.add_rounded,
          size: 30.0,
          color: Colors.grey.shade900,
        ),
      ),
    );
  }

  void getManualConfigsFromHive() {
    manualConfigsDataList.clear();
    Hive.box<VPNConfigModel>('manualConfigs_Box').values.forEach(
      (model) {
        manualConfigsDataList.add(model);
      },
    );
  }
}
