// import 'dart:html';
import 'package:budget_tracker/model/transaction_item.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/budget_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TransactionItem> items = [];

  @override
  Widget build(BuildContext context) {
    final budgetService = Provider.of<BudgetService>(context);
    final screenSize = MediaQuery.of(context).size;
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    // String newText = "R\$ " + formatter.format(value / 100);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          showDialog(
              context: context,
              builder: (context) {
                return AddTransactionDialog(itemToAdd: (transactionItem) {
                  setState(() {
                    items.add(transactionItem);
                  });
                });
              });
        }),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Consumer<BudgetService>(
                    builder: ((context, value, child) {
                      return CircularPercentIndicator(
                        radius: screenSize.width / 4,
                        lineWidth: 10.0,
                        percent: .5,
                        backgroundColor: Colors.white,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "\Rp 0",
                              style: TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Balance",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Budget: \Rp " +
                                  formatter.format(value.budget).toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        progressColor: Theme.of(context).colorScheme.primary,
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Items",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                ...List.generate(
                    items.length,
                    (index) => TransactionCard(
                          item: items[index],
                        )), // TransactionCard(text: "Kopi", amount: 10000, isExpense: true),
                // TransactionCard(text: "Kopi", amount: 10000, isExpense: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final TransactionItem item;
  const TransactionCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 25),
              blurRadius: 50,
            )
          ],
        ),
        padding: const EdgeInsets.all(15),
        width: screenSize.width,
        child: Row(
          children: [
            Text(
              item.itemTitle,
              style: TextStyle(fontSize: 18),
            ),
            const Spacer(),
            Text(
              (!item.isExpense ? "+ " : "- ") + item.amount.toString(),
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

class AddTransactionDialog extends StatefulWidget {
  final Function(TransactionItem) itemToAdd;
  const AddTransactionDialog({required this.itemToAdd, Key? key})
      : super(key: key);

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final TextEditingController itemTitleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  bool _isExpenseController = true;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      child: SizedBox(
          width: screenSize.width / 1.3,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Text(
                  "Add an expense",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: itemTitleController,
                  decoration:
                      const InputDecoration(hintText: "Name of expense"),
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(hintText: "Amount in Rp"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Is expense?"),
                    Switch.adaptive(
                        value: _isExpenseController,
                        onChanged: (b) {
                          setState(() {
                            _isExpenseController = b;
                          });
                        })
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: (() {
                      if (amountController.text.isNotEmpty &&
                          itemTitleController.text.isNotEmpty) {
                        widget.itemToAdd(TransactionItem(
                            amount: double.parse(amountController.text),
                            itemTitle: itemTitleController.text,
                            isExpense: _isExpenseController));
                        Navigator.pop(context);
                      }
                    }),
                    child: const Text("Add"))
              ],
            ),
          )),
    );
  }
}
