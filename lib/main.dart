import 'package:bloc/bloc.dart';
import 'package:coinapp/app.dart';
import 'package:coinapp/app_view.dart';
import 'package:coinapp/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());

}

  @override
  Widget build(BuildContext context) {
    return const MyAppView();
  }