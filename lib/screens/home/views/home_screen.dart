import 'package:coinapp/add_expenses/add_expense.dart';
import 'package:coinapp/add_expenses/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:coinapp/add_expenses/blocs/create_expensebloc/create_expense_bloc.dart';
import 'package:coinapp/screens/home/blocs/get_expensesbloc/get_expenses_bloc.dart';
import 'package:coinapp/screens/home/views/entry_screen.dart';
import 'package:coinapp/screens/home/views/statistics_screen.dart';
import 'package:coinapp/screens/profile/views/login_screen.dart';
import 'package:expense_repo/expense_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  Color selectedItemColor = const Color.fromARGB(255, 1, 21, 92);
  Color unselectedItemColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    context.read<GetExpensesBloc>().add(GetExpenses());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        List<ExpenseEntity> expenses = [];
        if (state is GetExpensesSuccess) {
          expenses = state.expenses;
        } else if (state is GetExpensesFailure) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to fetch expenses'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 77, 161, 239),
            title: const Text('Coin App Home'),
            actions: [
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ],
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              currentIndex: index,
              selectedItemColor: selectedItemColor,
              unselectedItemColor: unselectedItemColor,
              onTap: (value) {
                setState(() {
                  index = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  backgroundColor: const Color.fromARGB(255, 66, 159, 235),
                  icon: Icon(
                    CupertinoIcons.home,
                    color: index == 0 ? selectedItemColor : unselectedItemColor,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.graph_circle_fill,
                    color: index == 1 ? selectedItemColor : unselectedItemColor,
                  ),
                  label: 'Stats',
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MultiBlocProvider(
                    providers: [
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
                    ],
                    child: const AddExpense(),
                  ),
                ),
              );
            },
            backgroundColor: const Color.fromARGB(255, 1, 21, 92),
            child: const Icon(CupertinoIcons.add),
          ),
          body: index == 0
              ? EntryScreen(expenses: expenses)
              : StatScreen(expenses: expenses),
        );
      },
    );
  }
}
