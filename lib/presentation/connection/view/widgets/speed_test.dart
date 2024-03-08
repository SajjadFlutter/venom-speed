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
    var uploadValue_number = uploadValueList[0];
    var uploadValue_text = uploadValueList[1];

    var downloadValueList = downloadValue.split(' ');
    var downloadValue_number = downloadValueList[0];
    var downloadValue_text = downloadValueList[1];

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
                            text: uploadValue_number,
                            style: const TextStyle(fontSize: 17.0)),
                        TextSpan(
                            text: ' $uploadValue_text/s',
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
                            text: downloadValue_number,
                            style: const TextStyle(fontSize: 17.0)),
                        TextSpan(
                            text: ' $downloadValue_text/s',
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
