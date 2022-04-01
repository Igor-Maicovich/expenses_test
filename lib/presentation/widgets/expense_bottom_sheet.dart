import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_expenses/models/expense.dart';
import 'package:test_expenses/repositories/expense_repo.dart';
import 'package:test_expenses/utils/test_styles.dart';
import 'package:uuid/uuid.dart';

class ExpenseBottomSheet extends StatefulWidget {
  final Expense? expense;
  final ExpenseRepository repository;
  const ExpenseBottomSheet({Key? key, this.expense, required this.repository}) : super(key: key);

  @override
  State<ExpenseBottomSheet> createState() => _ExpenseBottomSheetState();
}

class _ExpenseBottomSheetState extends State<ExpenseBottomSheet> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.expense?.value.toString());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5.h),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              label: const Text('Значение'),
            ),
            onChanged: (val) => setState(() {}),
          ),
          SizedBox(height: 5.h),
          ElevatedButton(
            child: Text(
              'Сохранить',
              style: TestStyles().title,
            ),
            onPressed: (controller.text.isNotEmpty)
                ? () {
                    widget.repository.setExpense(
                      Expense(
                          id: widget.expense?.id ?? const Uuid().v4(),
                          value: double.parse(controller.text),
                          dateTime: DateTime.now()),
                    );
                    Navigator.pop(context);
                  }
                : null,
          ),
          SizedBox(height: 2.h),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
