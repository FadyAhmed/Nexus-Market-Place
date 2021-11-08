import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/table_row.dart';
import 'package:ds_market_place/constants.dart';
import 'package:flutter/material.dart';

class PurchaseItemScreen extends StatefulWidget {
  const PurchaseItemScreen({Key? key}) : super(key: key);

  @override
  _PurchaseItemScreenState createState() => _PurchaseItemScreenState();
}

class _PurchaseItemScreenState extends State<PurchaseItemScreen> {
  // this is dummy
  int amount = 0;
  void _increaseAmount() {
    setState(() {
      amount++;
    });
  }

  void _decreaseAmount() {
    setState(() {
      if (amount - 1 >= 0) amount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Name"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  kLogo,
                  width: MediaQuery.of(context).size.width / 3,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Table(
            children: [
              tableRow("Name: ", "book", context),
              tableRow("", "", context),
              tableRow("Description: ", "hard cover", context),
              tableRow("", "", context),
              tableRow("Seller: ", "fady", context),
              tableRow("", "", context),
              tableRow("Available amount: ", "4", context),
              tableRow("", "", context),
              tableRow("Price: ", "\$10", context),
            ],
          ),
          const SizedBox(height: 50),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                  child: Text("Amount",
                      style: TextStyle(
                          color: Colors.grey.shade700, fontSize: 20))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(title: "-", onPressed: _decreaseAmount),
                  const SizedBox(width: 20),
                  Text(
                    amount.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 20),
                  RoundedButton(title: "+", onPressed: _increaseAmount),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                  width: MediaQuery.of(context).size.width - 120,
                  height: 45,
                  child: RoundedButton(
                      title: "Purchase",
                      onPressed: () {
                        showSnackbar(
                            context, Text("Item purchased succesfully"));
                        Navigator.of(context).pop();
                      })),
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }
}
