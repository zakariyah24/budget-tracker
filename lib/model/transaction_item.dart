import 'package:hive/hive.dart';
part 'transaction_item.g.dart'; // Make sure to include this

@HiveType(typeId: 1)
class TransactionItem {
  @HiveType(typeId: 0)
  String itemTitle;
  @HiveType(typeId: 1)
  double amount;
  @HiveType(typeId: 2)
  bool isExpense;
  TransactionItem(
      {required this.amount, required this.itemTitle, required this.isExpense});
}
