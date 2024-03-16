// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/constants/images.dart';
import '../../../main.dart';
import '../../connection/view/connection_page.dart';
import '../bloc/cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Form
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginPageStatus();
  }

  @override
  void dispose() {
    emailController.dispose();
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
    var secondaryHeaderColor = Theme.of(context).secondaryHeaderColor;
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
                        Images.loginImage,
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
                          controller: emailController,
                          cursorColor: primaryColor,
                          style: TextStyle(
                            color: Colors.grey.shade100,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 18.0),
                            hintText: 'ایمیل یا نام کاربری',
                            hintStyle: const TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFF7070B1),
                            ),
                            filled: true,
                            fillColor: secondaryHeaderColor,
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
                              return 'لطفا ایمیل یا نام کاربری خود را وارد کنید.';
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
                                horizontal: 30.0, vertical: 18.0),
                            hintText: 'رمز عبور',
                            hintStyle: const TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 112, 112, 177),
                            ),
                            filled: true,
                            fillColor: secondaryHeaderColor,
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
                        SizedBox(height: height * 0.015),
                        // accept the terms
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Text('با ورود شما شرایط و قوانین را می پذیرید',
                              style: textTheme.labelMedium),
                        ),
                        SizedBox(height: height * 0.025),
                        // sign in button
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                // call login api
                                BlocProvider.of<LoginCubit>(context)
                                    .checkLoginEvent(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            child: BlocConsumer<LoginCubit, LoginState>(
                              listener: (context, state) {
                                if (state.loginStatus is LoginOn) {
                                  var route = MaterialPageRoute(
                                    builder: (context) =>
                                        const ConnectionPage(),
                                  );
                                  Navigator.push(context, route);
                                  // save data
                                  setLoginStatus(true);
                                }
                                if (state.loginStatus is LoginOff) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      textStyle: textTheme.labelMedium!,
                                      message:
                                          "نام کاربری یا رمز عبور صحیح نمی باشد!",
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                // Loading
                                if (state.loginStatus is LoadingLogin) {
                                  return SpinKitThreeBounce(
                                    color: Colors.grey.shade900,
                                    size: 20.0,
                                  );
                                }
                                // Login off
                                if (state.loginStatus is LoginInitial ||
                                    state.loginStatus is LoginOff) {
                                  return Text('ادامه',
                                      style: textTheme.labelLarge);
                                }
                                return Container();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        // buy subscription button
                        Center(
                          child: SizedBox(
                            width: 260,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF178F1D),
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform(
                                    transform: Matrix4.rotationY(110) *
                                        Matrix4.rotationX(110),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.grey.shade100,
                                      size: 18.0,
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Text('خرید اشتراک و تست رایگان',
                                      style: textTheme.labelMedium),
                                  const SizedBox(width: 6.0),
                                ],
                              ),
                            ),
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

  Future<void> setLoginStatus(bool isLogin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', isLogin);
  }

  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLogin') ?? false;
  }

  void _checkLoginPageStatus() async {
    bool isLogin = await getLoginStatus();
    if (isLogin) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ConnectionPage(),
      ));
    } else {
      return;
    }
  }
}
