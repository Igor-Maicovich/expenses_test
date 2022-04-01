import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_expenses/models/expense.dart';

class ExpenseRepository {
  final String userId;
  final CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection('Users');

  ExpenseRepository(this.userId);

  Stream<List<Expense>> streamAllExpenses() async* {
    yield* collection
        .doc(userId)
        .collection('Expenses')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((event) => event.docs.map((doc) => Expense.fromJson(doc.data())).toList());
  }

  Future<void> setExpense(Expense expense) async {
    return await collection.doc(userId).collection('Expenses').doc(expense.id).set(expense.toJson());
  }

  Future<void> deleteExpense(String expenseId) async {
    return await collection.doc(userId).collection('Expenses').doc(expenseId).delete();
  }
}
