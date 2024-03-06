import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/theme/my_theme.dart';
import 'presentation/add_config/bloc/add_config_bloc.dart';
import 'presentation/add_config/view/add_config_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AddConfigBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Venom Speed',
      theme: MyTheme.defaultTheme,
      // برای راستچین کردن اپلیکیشن
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('fa', ''),
      supportedLocales: const [
        Locale('fa'), // persian(farsi)
        Locale('en'), // English
      ],
      home: const AddConfigPage(),
    );
  }

  static void changeColor() {
    // theme
    var scaffoldBackgroundColor = const Color(0xff07074f);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }
}
