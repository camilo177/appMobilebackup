import 'package:coinapp/screens/home/blocs/bloc/get_expenses_bloc.dart';
import 'package:coinapp/screens/home/views/home_screen.dart';
import 'package:expense_repo/expense_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coin App',
      theme: ThemeData(
          colorScheme: ColorScheme.light(
        background: Colors.white,
        onBackground: Colors.black,
        primary: Colors.blue,
        secondary: Colors.green,
        tertiary: Colors.red,
      )),
      home: BlocProvider(
        create: (context) => GetExpensesBloc(
          FirebaseExpense())..add(GetExpenses()),
        child: HomeScreen(),
      ),
    );
  }
}
