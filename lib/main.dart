import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'common/bloc/change_index_cubit.dart';
import 'common/bloc/change_selected_config_cubit.dart';
import 'common/theme/my_theme.dart';
import 'infrastructure/models/vpn_config_model/vpn_config_model.dart';
import 'infrastructure/providers/server_api_provdier.dart';
import 'infrastructure/repository/server_repository.dart';
import 'presentation/add_config/bloc/add_config_bloc.dart';
import 'presentation/config_selection/bloc/server_cubit/server_cubit.dart';
import 'presentation/connection/bloc/timer_cubit.dart';
import 'presentation/login/login_page.dart';

void main() async {
  // init Hive
  await Hive.initFlutter();
  Hive.registerAdapter(VPNConfigModelAdapter());
  await Hive.openBox<VPNConfigModel>('manualConfigs_Box');
  await Hive.openBox<VPNConfigModel>('selectedConfig_Box');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddConfigBloc()),
        BlocProvider(create: (context) => ChangeIndexCubit()),
        BlocProvider(create: (context) => ChangeSelectedConfigCubit()),
        BlocProvider(create: (context) => TimerCubit()),
        BlocProvider(
          create: (context) => ServerCubit(
            ServerRepository(ServerApiProvider(Dio())),
          ),
        ),
      ],
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
      home: const LoginPage(),
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
