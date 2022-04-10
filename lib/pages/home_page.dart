// import 'dart:html';
import 'package:budget_tracker/model/transaction_item.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TransactionItem> items = [];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          setState(() {
            items.add(TransactionItem(
                amount: 5.99, itemTitle: "Food", isExpense: true));
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
                Align(
                  alignment: Alignment.topCenter,
                  child: CircularPercentIndicator(
                    radius: screenSize.width / 4,
                    lineWidth: 10.0, // how thick the line is
                    percent: .5, // percent goes from 0 -> 1
                    backgroundColor: Colors.white,
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "\Rp 0",
                          style: TextStyle(
                              fontSize: 48, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Balance",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),

                    progressColor: Theme.of(context).colorScheme.primary,
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
  // final String text;
  // final double amount;
  // final bool isExpense;
  // const TransactionCard(
  //     {Key? key,
  //     required this.text,
  //     required this.amount,
  //     required this.isExpense})
  //     : super(key: key);

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
