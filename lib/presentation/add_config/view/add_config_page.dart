import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_icon_button.dart';
import '../../../../controllers/index_controller.dart';
import '../../../configs_data/configs_data_list.dart';
import '../../../core/constants/images.dart';
import '../../../models/vpn_config_model.dart';
import '../../config_selection/view/widgets/config_item.dart';
import '../bloc/add_config_bloc.dart';
import '../bloc/add_config_event.dart';
import '../bloc/add_config_state.dart';

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
    // controller
    final IndexController indexController = Get.put(IndexController());
    // theme
    var textTheme = Theme.of(context).textTheme;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var cardColor = Theme.of(context).cardColor;
    // device size
    var width = MediaQuery.of(context).size.width;
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
      body: Column(
        children: [
          SizedBox(height: height * 0.03),
          // Enter config
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // config textField
                SizedBox(
                  width: width * 0.76,
                  child: TextFormField(
                    controller: configController,
                    cursorColor: primaryColor,
                    style: TextStyle(
                      color: Colors.grey.shade100,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 20.0),
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
                // add button
                GestureDetector(
                  onTap: () {
                    customConfigsDataList.add(
                      VPNConfigModel(
                        countryImage: Images.germanyImage,
                        countryName: 'آلمان',
                        config: configController.text,
                        ping: '110ms',
                      ),
                    );
                    BlocProvider.of<AddConfigBloc>(context)
                        .add(AddConfigEvent());
                  },
                  child: Container(
                    width: 65.0,
                    height: 65.0,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Icon(
                      Icons.add_rounded,
                      color: Colors.grey.shade900,
                      size: 35.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.015),
          // custom configs list
          BlocBuilder<AddConfigBloc, AddConfigState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.separated(
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
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12.0),
                  itemCount: customConfigsDataList.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
