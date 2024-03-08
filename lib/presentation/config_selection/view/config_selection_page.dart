import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../common/bloc/change_index_cubit.dart';
import '../../../configs_data/configs_data_list.dart';
import '../../../controllers/index_controller.dart';
import '../../../core/constants/images.dart';
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
    // controller
    final IndexController indexController = Get.put(IndexController());
    // theme
    var textTheme = Theme.of(context).textTheme;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var cardColor = Theme.of(context).cardColor;
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
                  children: [
                    SelectionListButton(
                      cardColor: cardColor,
                      title: 'کانفیگ اختصاصی',
                      state: state,
                      index: 0,
                      pageController: pageController,
                    ),
                    SelectionListButton(
                      cardColor: cardColor,
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
              controller: pageController,
              children: [
                ServerConfigsListWidget(
                  indexController: indexController,
                  cardColor: cardColor,
                  primaryColor: primaryColor,
                  textTheme: textTheme,
                ),
                ManualConfigsListWidget(
                  indexController: indexController,
                  cardColor: cardColor,
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
    required this.cardColor,
    required this.title,
    required this.state,
    required this.index,
    required this.pageController,
  });

  final Color cardColor;
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
          color: index == state ? cardColor : Colors.transparent,
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
    required this.indexController,
    required this.cardColor,
    required this.primaryColor,
    required this.textTheme,
  });

  final IndexController indexController;
  final Color cardColor;
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
          indexController: indexController,
          cardColor: cardColor,
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
    required this.indexController,
    required this.cardColor,
    required this.primaryColor,
    required this.textTheme,
  });

  final IndexController indexController;
  final Color cardColor;
  final Color primaryColor;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddConfigBloc, AddConfigState>(
        builder: (context, state) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ConfigItem(
                index: index,
                indexController: indexController,
                cardColor: cardColor,
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
}
