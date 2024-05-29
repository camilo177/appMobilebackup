import 'package:coinapp/add_expenses/add_expense.dart';
import 'package:coinapp/add_expenses/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:coinapp/add_expenses/blocs/create_expensebloc/create_expense_bloc.dart';
import 'package:coinapp/screens/home/blocs/bloc/get_expenses_bloc.dart';
import 'package:coinapp/screens/home/views/entry_screen.dart';
import 'package:coinapp/screens/home/views/statistics_screen.dart';
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
  late Color selectedItem = Colors.black;
  Color unselectedItem = Colors.grey;

  @override
  void initState() {
    selectedItem = Colors.black;
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
          appBar: AppBar(),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  index = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.blue,
                  icon: Icon(
                    CupertinoIcons.home,
                    color: index == 0 ? selectedItem : unselectedItem,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.graph_circle_fill,
                    color: index == 1 ? selectedItem : unselectedItem,
                  ),
                  label: 'Stats',
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
            child: const Icon(CupertinoIcons.add),
          ),
          body: index == 0
              ? EntryScreen(expenses: expenses) // Pass expenses to EntryScreen as a named parameter
              : StatScreen(expenses: expenses), // Pass expenses to StatScreen
        );
      },
    );
  }
}
