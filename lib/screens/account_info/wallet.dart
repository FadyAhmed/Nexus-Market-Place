import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:flutter/material.dart';

enum TransactionType { withdraw, deposit }

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

final _formKey = GlobalKey<FormState>();

class _WalletScreenState extends State<WalletScreen> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cvvNumberController = TextEditingController();

  TransactionType? _transactionType = TransactionType.deposit;
  @override
  Widget build(BuildContext context) {
    List<KFormField> fields = [
      KFormField(
          controller: _amountController,
          hint: 'Enter amount ',
          label: "Amount",
          obsecure: false,
          validator: (String? s) => s == null || s.isEmpty
              ? 'Empty'
              : double.tryParse(s) == null
                  ? 'Not A Number!'
                  : null),
      KFormField(
          controller: _cardNumberController,
          hint: 'Enter Card Number',
          label: "Card number",
          obsecure: false,
          validator: (String? s) => s == null || s.isEmpty
              ? 'Empty'
              : double.tryParse(s) == null
                  ? 'Not A Number!'
                  : s.length != 12
                      ? "Wrong number"
                      : null),
      KFormField(
          controller: _cvvNumberController,
          hint: 'Enter CVV',
          label: "CVV",
          obsecure: false,
          validator: (String? s) => s == null || s.isEmpty
              ? 'Empty'
              : double.tryParse(s) == null
                  ? 'Not A Number!'
                  : s.length != 3
                      ? "Wrong number"
                      : null),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet"), centerTitle: true),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Text(
                "Balance:   \$1500",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: fields
                              .map(
                                (field) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: myTextFormField(
                                      context: context,
                                      validator: field.validator,
                                      textInputType: field.textInputType,
                                      controller: field.controller,
                                      hint: field.hint,
                                      label: field.label),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(
                    children: [
                      Radio<TransactionType>(
                        value: TransactionType.deposit,
                        groupValue: _transactionType,
                        onChanged: (TransactionType? value) {
                          setState(() {
                            _transactionType = value;
                          });
                        },
                        activeColor: Colors.black87,
                      ),
                      const Text("Deposit"),
                    ],
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      Radio<TransactionType>(
                          value: TransactionType.withdraw,
                          groupValue: _transactionType,
                          onChanged: (TransactionType? value) {
                            setState(() {
                              _transactionType = value;
                            });
                          },
                          activeColor: Colors.black87),
                      const Text("Withdraw"),
                    ],
                  ),
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RoundedButton(
                        onPressed: () {
                          _formKey.currentState!.validate();

                          showSnackbar(context, Text("Transaction done"));

                          Navigator.of(context).pop();
                        },
                        title: 'Confirm',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
