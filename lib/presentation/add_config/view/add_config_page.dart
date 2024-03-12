// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../common/widgets/custom_icon_button.dart';
import '../../../core/constants/images.dart';
import '../../../infrastructure/models/vpn_config_model/vpn_config_model.dart';
import '../bloc/add_config_bloc.dart';
import '../bloc/add_config_event.dart';

class AddConfigPage extends StatefulWidget {
  const AddConfigPage({super.key});

  @override
  State<AddConfigPage> createState() => _AddConfigPageState();
}

class _AddConfigPageState extends State<AddConfigPage> {
  TextEditingController configController = TextEditingController();

  @override
  void dispose() {
    configController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // theme
    var textTheme = Theme.of(context).textTheme;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var cardColor = Theme.of(context).cardColor;
    // device size
    // var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
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
          CustomIconButton(
              cardColor: cardColor, function: () => Navigator.pop(context)),
        ],
      ),
      // body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.04),
            // title
            Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 15.0),
              child: Text('افزودن کانفیگ', style: textTheme.labelMedium),
            ),
            // Enter config
            SizedBox(
              child: TextFormField(
                controller: configController,
                cursorColor: primaryColor,
                style: TextStyle(
                  color: Colors.grey.shade100,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 18.0),
                  hintText: 'کانفیگ خود را وارد کنید...',
                  hintStyle: const TextStyle(
                    fontSize: 15.0,
                    color: Color(0xFF7070B1),
                  ),
                  filled: true,
                  fillColor: cardColor,
                  border: const OutlineInputBorder(
                    gapPadding: 20.0,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide.none,
                  ),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفا کانفیگ خود را وارد کنید.';
                  }
                  return null;
                },
              ),
            ),

            SizedBox(height: height * 0.03),
            // add config button
            SizedBox(
              width: double.infinity,
              height: 65,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () async {
                  if (configController.text.isNotEmpty) {
                    await Hive.box<VPNConfigModel>('VPNConfigModel_Box').add(
                      VPNConfigModel(
                        countryImage: Images.germanyImage,
                        countryName: 'آلمان',
                        config: configController.text,
                        ping: '110ms',
                      ),
                    );
                  }

                  BlocProvider.of<AddConfigBloc>(context).add(AddConfigEvent());

                  Navigator.pop(context);
                },
                child: Text('افزودن کانفیگ', style: textTheme.labelLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
