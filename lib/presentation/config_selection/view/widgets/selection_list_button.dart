import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/bloc/change_index_cubit.dart';
import '../select_config_page.dart';

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
        SelectConfigPage.configTitle = title;
        // change index
        BlocProvider.of<ChangeIndexCubit>(context).changeIndexEvent(index);

        if (title == 'کانفیگ اختصاصی') {
          pageController.animateToPage(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        } else {
          pageController.animateToPage(1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
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
