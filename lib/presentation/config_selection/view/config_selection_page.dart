import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../common/bloc/change_index_cubit.dart';
import '../../../configs_data/configs_data_list.dart';
import '../../../core/constants/images.dart';
import '../../../infrastructure/models/vpn_config_model/vpn_config_model.dart';
import '../../add_config/bloc/add_config_bloc.dart';
import '../../add_config/bloc/add_config_state.dart';
import '../../add_config/view/add_config_page.dart';
import 'widgets/config_item.dart';

class ConfigSelectionPage extends StatelessWidget {
  const ConfigSelectionPage({super.key});

  static String configTitle = '';
  static PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // theme
    var textTheme = Theme.of(context).textTheme;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var secondaryHeaderColor = Theme.of(context).secondaryHeaderColor;
    // device size
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      drawer: Drawer(backgroundColor: scaffoldBackgroundColor),
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
      body: Column(
        children: [
          // selection list
          BlocBuilder<ChangeIndexCubit, int>(
            builder: (context, state) {
              return Container(
                width: width,
                margin: const EdgeInsets.only(
                    top: 20.0, right: 20.0, left: 20.0, bottom: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectionListButton(
                      secondaryHeaderColor: secondaryHeaderColor,
                      title: 'کانفیگ اختصاصی',
                      state: state,
                      index: 0,
                      pageController: pageController,
                    ),
                    SelectionListButton(
                      secondaryHeaderColor: secondaryHeaderColor,
                      title: 'کانفیگ دستی',
                      state: state,
                      index: 1,
                      pageController: pageController,
                    ),
                  ],
                ),
              );
            },
          ),
          // lists
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                ServerConfigsListWidget(
                  secondaryHeaderColor: secondaryHeaderColor,
                  primaryColor: primaryColor,
                  textTheme: textTheme,
                ),
                ManualConfigsListWidget(
                  secondaryHeaderColor: secondaryHeaderColor,
                  primaryColor: primaryColor,
                  textTheme: textTheme,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectionListButton extends StatelessWidget {
  const SelectionListButton({
    super.key,
    required this.secondaryHeaderColor,
    required this.title,
    required this.state,
    required this.index,
    required this.pageController,
  });

  final Color secondaryHeaderColor;
  final int state;
  final int index;
  final String title;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    // device size
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        ConfigSelectionPage.configTitle = title;
        // change index
        BlocProvider.of<ChangeIndexCubit>(context).changeIndexEvent(index);

        if (title == 'کانفیگ اختصاصی') {
          pageController.animateToPage(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);

          mainConfigsDataList = serverConfigsDataList;
        } else {
          pageController.animateToPage(1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);

          mainConfigsDataList = manualConfigsDataList;
        }
      },
      child: Container(
        width: width / 2 - 32.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: index == state ? secondaryHeaderColor : Colors.transparent,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }
}

class ServerConfigsListWidget extends StatelessWidget {
  const ServerConfigsListWidget({
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
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        // config item
        return ConfigItem(
          index: index,
          secondaryHeaderColor: secondaryHeaderColor,
          primaryColor: primaryColor,
          textTheme: textTheme,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12.0),
      itemCount: serverConfigsDataList.length,
    );
  }
}

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
              return ConfigItem(
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
