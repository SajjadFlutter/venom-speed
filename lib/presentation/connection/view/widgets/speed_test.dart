import 'package:flutter/material.dart';

import '../../../../core/constants/images.dart';

class SpeedTest extends StatelessWidget {
  const SpeedTest({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // upload
        Row(
          children: [
            Column(
              children: [
                Text('آپلود', style: textTheme.labelMedium),
                const SizedBox(height: 3.0),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: '35.8 ', style: TextStyle(fontSize: 17.0)),
                        TextSpan(
                            text: 'KB/s', style: TextStyle(fontSize: 12.0)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15.0),
            Image.asset(Images.upload, width: 35.0),
          ],
        ),
        // download
        Row(
          children: [
            Column(
              children: [
                Text('دانلود', style: textTheme.labelMedium),
                const SizedBox(height: 3.0),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: '55.6 ', style: TextStyle(fontSize: 17.0)),
                        TextSpan(
                            text: 'KB/s', style: TextStyle(fontSize: 12.0)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15.0),
            Image.asset(Images.download,
                width: 35.0, color: Colors.grey.shade100),
          ],
        ),
      ],
    );
  }
}
