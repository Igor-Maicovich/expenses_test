import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_expenses/models/expense.dart';
import 'package:test_expenses/presentation/widgets/expense_bottom_sheet.dart';
import 'package:test_expenses/repositories/expense_repo.dart';
import 'package:test_expenses/utils/test_styles.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final ExpenseRepository repository;
  const ExpenseItem({Key? key, required this.expense, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        repository.deleteExpense(expense.id);
      },
      child: ListTile(
        title: Text('${expense.value}', style: TestStyles().title),
        subtitle: Text(DateFormat('HH:mm  dd.MM.yyyy').format(expense.dateTime), style: TestStyles().subTitle),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            builder: (_) => ExpenseBottomSheet(expense: expense, repository: repository),
          );
        },
      ),
    );
  }
}
