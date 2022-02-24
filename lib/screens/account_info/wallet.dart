import 'dart:async';
import 'dart:io';

import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/providers/users_provider.dart';
import 'package:ds_market_place/view_models/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

enum TransactionType { withdraw, deposit }

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

final _formKey = GlobalKey<FormState>();

class _WalletScreenState extends State<WalletScreen> {
  WalletViewModel walletViewModel = GetIt.I();

  late StreamSubscription failureSub;
  late StreamSubscription snackBarSub;

  TextEditingController _amountController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cvvNumberController = TextEditingController();

  TransactionType? _transactionType = TransactionType.deposit;

  @override
  void initState() {
    super.initState();
    walletViewModel.getBalance();
    failureSub = walletViewModel.failureController.listen((failure) {
      if (failure != null) {
        showMessageDialogue(context, failure.message);
      }
    });
    failureSub = walletViewModel.snackBarController.listen((isDeposit) {
      if (isDeposit != null) {
        if (isDeposit) {
          showSnackbar(
              context, Text("${_amountController.text} is deposited."));
        } else {
          showSnackbar(
              context, Text("${_amountController.text} is withdrawn."));
        }
      }
    });
  }

  @override
  void dispose() {
    walletViewModel.clearFailure();
    walletViewModel.clearSnackBar();
    failureSub.cancel();
    snackBarSub.cancel();
    super.dispose();
  }

  void submitRequest() async {
    if (_formKey.currentState!.validate()) {
      if (_transactionType == TransactionType.deposit) {
        AddBalanceRequest addBalanceRequest = AddBalanceRequest(
          cardNum: _cardNumberController.text,
          amount: double.parse(_amountController.text),
          cvv: _cvvNumberController.text,
        );
        await walletViewModel.addBalance(addBalanceRequest);
      } else {
        RemoveBalanceRequest removeBalanceRequest = RemoveBalanceRequest(
          cardNum: _cardNumberController.text,
          amount: double.parse(_amountController.text),
          cvv: _cvvNumberController.text,
        );
        await walletViewModel.removeBalance(removeBalanceRequest);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context);
    List<KFormField> fields = [
      KFormField(
          controller: _amountController,
          hint: 'Enter amount ',
          label: "Amount",
          obsecure: false,
          validator: (String? s) {
            if (s == null || s.isEmpty) {
              return 'Empty';
            } else if (double.tryParse(s) == null) {
              return 'Not A Number!';
            } else if (double.parse(s) <= 0) {
              return 'invalid amount';
            } else if ((_transactionType == TransactionType.withdraw &&
                walletViewModel.balance! - double.parse(s) < 0)) {
              return 'insufficient balance';
            } else {
              return null;
            }
          }),
      KFormField(
          controller: _cardNumberController,
          hint: 'Enter Card Number',
          label: "Card number",
          obsecure: false,
          validator: (String? s) => s == null || s.isEmpty
              ? 'Empty'
              : double.tryParse(s) == null
                  ? 'Not A Number!'
                  : s.length != 16
                      ? "card number should be 16 digits"
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
                      ? "CVV should be 3 digits"
                      : null),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet"), centerTitle: true),
      body: GestureDetector(
        onTap: Platform.isWindows
            ? null
            : () {
                FocusScope.of(context).unfocus();
              },
        child: ListView(
          children: [
            const SizedBox(height: 30),
            Center(
              child: StreamBuilder<bool>(
                stream: walletViewModel.profileLoadingController,
                builder: (context, snapshot) {
                  if (snapshot.data ?? false) {
                    return CircularProgressIndicator();
                  }
                  return StreamBuilder<double>(
                    stream: walletViewModel.balanceController,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                      }
                      double balance = snapshot.data!;
                      return Text(
                        "Balance:   \$${balance.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.headline5,
                      );
                    },
                  );
                },
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
                      child: (userProvider.balanceLoadingStatus ==
                              LoadingStatus.loading)
                          ? Center(child: CircularProgressIndicator())
                          : StreamBuilder<bool>(
                              stream: walletViewModel.balanceLoadingController,
                              builder: (context, snapshot) {
                                if (snapshot.data ?? false) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                return RoundedButton(
                                  onPressed: submitRequest,
                                  title: 'Confirm',
                                );
                              },
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
