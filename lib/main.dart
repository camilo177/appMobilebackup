import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:coinapp/app.dart';
import 'package:coinapp/app_view.dart';
import 'package:coinapp/simple_bloc_observer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './generated/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('es', ''),
      ],
      locale: const Locale('en'),
      home: MyAppView(),
    );
  }
}


@override
Widget build(BuildContext context) {
  return const MyAppView();
}
