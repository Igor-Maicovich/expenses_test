import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_expenses/bloc/auth_bloc/auth_bloc.dart';
import 'package:test_expenses/models/expense.dart';
import 'package:test_expenses/presentation/widgets/expense_bottom_sheet.dart';
import 'package:test_expenses/presentation/widgets/expense_item.dart';
import 'package:test_expenses/repositories/expense_repo.dart';
import 'package:test_expenses/utils/test_styles.dart';

class ExpensesScreen extends StatelessWidget {
  final ExpenseRepository repository;
  const ExpensesScreen({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout_rounded),
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEvent.logOut());
          },
        ),
        title: Text('Расходы', style: TestStyles().title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                builder: (_) => ExpenseBottomSheet(repository: repository),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Expense>>(
          stream: repository.streamAllExpenses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => ExpenseItem(
                    expense: snapshot.data![index],
                    repository: repository,
                  ),
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                );
              }
              return Center(
                child: Text('Список пуст', style: TestStyles().title),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
