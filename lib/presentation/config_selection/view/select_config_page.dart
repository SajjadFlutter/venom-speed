import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venom_speed/common/widgets/custom_drawer.dart';

import '../../../common/bloc/change_index_cubit.dart';
import '../../../core/constants/images.dart';
import 'widgets/manual_configs_list_widget.dart';
import 'widgets/selection_list_button.dart';
import 'widgets/server_configs_list_widget.dart';

class SelectConfigPage extends StatelessWidget {
  const SelectConfigPage({super.key});

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
