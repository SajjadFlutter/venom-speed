import 'package:flutter/material.dart';

import '../../../core/constants/images.dart';
import '../../../main.dart';
import '../connection/view/connection_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Form
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // change statusbar color
    MyApp.changeColor();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.46,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Image.asset(
                        Images.signinImage,
                        width: width,
                        height: height * 0.45,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.1, left: 50.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Logo
                            Image.asset(
                              Images.logo,
                              width: 110.0,
                            ),
                            // Title
                            const Text(
                              'Venom Speed',
                              style: TextStyle(
                                fontFamily: 'lora',
                                fontSize: 26.0,
                                color: Color(0xff697dd1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Text('ورود', style: textTheme.titleLarge),
                        ),
                        SizedBox(height: height * 0.02),
                        // username
                        TextFormField(
                          controller: usernameController,
                          cursorColor: primaryColor,
                          style: TextStyle(
                            color: Colors.grey.shade100,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 35.0, vertical: 20.0),
                            hintText: 'نام کاربری',
                            hintStyle: const TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFF7070B1),
                            ),
                            filled: true,
                            fillColor: cardColor,
                            border: const OutlineInputBorder(
                              gapPadding: 20.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'لطفا نام کاربری را وارد کنید.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.015),
                        // password
                        TextFormField(
                          controller: passwordController,
                          cursorColor: primaryColor,
                          style: TextStyle(
                            color: Colors.grey.shade100,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 35.0, vertical: 20.0),
                            hintText: 'رمز عبور',
                            hintStyle: const TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 112, 112, 177),
                            ),
                            filled: true,
                            fillColor: cardColor,
                            border: const OutlineInputBorder(
                              gapPadding: 20.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'لطفا گذرواژه خود را وارد کنید.';
                            } else if (value.length < 8) {
                              return 'حداقل 8 کاراکتر وارد کنید.';
                            } else if (value.length > 20) {
                              return 'حداکثر 20 کاراکتر وارد کنید.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.01),
                        // accept the terms
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('با ورود شما شرایط و قوانین را می پذیرید',
                                  style: textTheme.labelMedium),
                              const SizedBox(height: 10.0),
                              // buy subscription button
                              SizedBox(
                                width: 150,
                                height: 40,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF178F1D),
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text('خرید اشتراک',
                                      style: textTheme.labelMedium),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        // sign in button
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
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                // userProvider.callRegisterApi(nameController.text, passwordController.text);
                                var route = MaterialPageRoute(
                                  builder: (context) => const ConnectionPage(),
                                );
                                Navigator.push(context, route);
                              }
                            },
                            child: Text('ادامه', style: textTheme.labelLarge),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
