import 'package:coinapp/add_expenses/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:coinapp/add_expenses/blocs/create_expensebloc/create_expense_bloc.dart';
import 'package:coinapp/screens/home/blocs/get_expensesbloc/get_expenses_bloc.dart';
import 'package:coinapp/screens/home/views/home_screen.dart';
import 'package:coinapp/screens/profile/blocs/authbloc/auth_bloc.dart';
import 'package:expense_repo/expense_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetExpensesBloc(
            FirebaseExpense(),
          )..add(GetExpenses()),
        ),
        BlocProvider(
          create: (context) => CreateCategoryBloc(
            FirebaseExpense(),
          ),
        ),
        BlocProvider(
          create: (context) => CreateExpenseBloc(
            FirebaseExpense(),
          ),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            FirebaseAuth.instance,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coin App',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            background: Colors.white,
            onBackground: Colors.black,
            primary: Colors.blue,
            secondary: Colors.green,
            tertiary: Colors.red,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
