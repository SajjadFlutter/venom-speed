import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.secondaryHeaderColor,
    required this.function,
  });

  final Color secondaryHeaderColor;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 20.0,
        decoration: BoxDecoration(
          color: secondaryHeaderColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}
