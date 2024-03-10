import 'package:flutter/material.dart';

import '../../../../core/constants/images.dart';

class SpeedTest extends StatelessWidget {
  const SpeedTest({
    super.key,
    required this.textTheme,
    required this.uploadValue,
    required this.downloadValue,
  });

  final TextTheme textTheme;
  final String uploadValue;
  final String downloadValue;

  @override
  Widget build(BuildContext context) {
    var uploadValueList = uploadValue.split(' ');
    var uploadvalueNumber = uploadValueList[0];
    var uploadvalueText = uploadValueList[1];

    var downloadValueList = downloadValue.split(' ');
    var downloadvalueNumber = downloadValueList[0];
    var downloadvalueText = downloadValueList[1];

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
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: uploadvalueNumber,
                            style: const TextStyle(fontSize: 17.0)),
                        TextSpan(
                            text: ' $uploadvalueText/s',
                            style: const TextStyle(fontSize: 12.0)),
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
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: downloadvalueNumber,
                            style: const TextStyle(fontSize: 17.0)),
                        TextSpan(
                            text: ' $downloadvalueText/s',
                            style: const TextStyle(fontSize: 12.0)),
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
