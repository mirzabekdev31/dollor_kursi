import 'package:dollor_kursi/pages/bloc/main_bloc.dart';
import 'package:dollor_kursi/pages/calculate/calculate_page.dart';
import 'package:dollor_kursi/pages/main_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/di.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(
    EasyLocalization(
      path: 'assets/tr',
      supportedLocales: const [
        Locale("uz", "UZ"),
        Locale("uz", "UZC"),
        Locale("ru", "RU"),
        Locale("en", "EN"),
      ],
      startLocale: const Locale("uz", "UZ"),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) {
          return BlocProvider(
            create: (_) => MainBloc(di.get())..add(MainGetLastEvent()),
            child: const MainPage(),
          );
        },
        // InfoPage.id:(context)=>const InfoPage(),
        CalculatePage.route:(context)=>const CalculatePage()
      },
    );
  }
}