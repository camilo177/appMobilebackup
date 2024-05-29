import 'package:coinapp/add_expenses/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:expense_repo/expense_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'blocs/create_expensebloc/create_expense_bloc.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  late ExpenseEntity expense;

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = ExpenseEntity(
      expenseId: '',
      category: Category.empty, // Assuming Category has a default empty instance
      date: DateTime.now(),
      amount: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Coin App Expenses'),
        ),
        body: BlocListener<CreateExpenseBloc, CreateExpenseState>(
          listener: (context, state) {
            if (state is CreateExpenseSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Expense created successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is CreateExpenseFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to create expense'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add your expenses here',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 7, 57, 236),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: expenseController,
                  decoration: const InputDecoration(
                    hintText: 'Expense',
                    prefixIcon: Icon(CupertinoIcons.money_dollar),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: dateController,
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true, // Make the field read-only
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000), // Set a start date for the date picker
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (newDate != null) {
                      setState(() {
                        dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                        expense.date = newDate; // Update the expense object with the new date
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Date',
                    prefixIcon: Icon(CupertinoIcons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  readOnly: true,
                  controller: categoryController,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) {
                        TextEditingController nameController = TextEditingController();
                        return BlocProvider.value(
                          value: context.read<CreateCategoryBloc>(),
                          child: BlocListener<CreateCategoryBloc, CreateCategoryState>(
                            listener: (context, state) {
                              if (state is CreateCategorySuccess) {
                                Navigator.pop(ctx); // Close the dialog
                                setState(() {
                                  categoryController.text = nameController.text; // Update the main form's category field
                                  expense.category = Category(
                                    categoryId: const Uuid().v4(),
                                    name: nameController.text,
                                    totalExpenses: 0,
                                  );
                                });
                              } else if (state is CreateCategoryFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to create category'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            child: AlertDialog(
                              title: const Text('Add Category'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: nameController,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: const InputDecoration(
                                      hintText: 'New Category Name',
                                      prefixIcon: Icon(CupertinoIcons.square_fill_line_vertical_square),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      onPressed: () {
                                        if (nameController.text.isNotEmpty) {
                                          Category category = Category.empty;
                                          category.categoryId = const Uuid().v4();
                                          category.name = nameController.text; // Update with the name from the dialog
                                          category.totalExpenses = 0;
                                          context.read<CreateCategoryBloc>().add(CreateCategoryRequested(category));
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(255, 1, 21, 92),
                                      ),
                                      child: const Text(
                                        'Add Category',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  decoration: const InputDecoration(
                    hintText: 'Category',
                    prefixIcon: Icon(CupertinoIcons.square_fill_line_vertical_square),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(CupertinoIcons.add, color: Colors.grey),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      // Add functionality to handle expense submission
                      setState(() {
                        expense.expenseId = const Uuid().v4();
                        expense.amount = int.parse(expenseController.text);
                      });
                      context.read<CreateExpenseBloc>().add(CreateExpenseRequested(expense));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 1, 21, 92),
                    ),
                    child: const Text(
                      'Add Expense',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
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

  @override
  void dispose() {
    expenseController.dispose();
    dateController.dispose();
    categoryController.dispose();
    super.dispose();
  }
}
