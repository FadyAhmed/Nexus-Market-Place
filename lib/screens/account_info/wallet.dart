import 'dart:async';
import 'dart:io';

import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/providers/users_provider.dart';
import 'package:ds_market_place/states/balance_state.dart';
import 'package:ds_market_place/view_models/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

enum TransactionType { withdraw, deposit }

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

final _formKey = GlobalKey<FormState>();

class _WalletScreenState extends ConsumerState<WalletScreen> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cvvNumberController = TextEditingController();

  TransactionType? _transactionType = TransactionType.deposit;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      ref.read(balanceProvider.notifier).getBalance,
    );
  }

  void submitRequest() async {
    if (_formKey.currentState!.validate()) {
      if (_transactionType == TransactionType.deposit) {
        AddBalanceRequest addBalanceRequest = AddBalanceRequest(
          cardNum: _cardNumberController.text,
          amount: double.parse(_amountController.text),
          cvv: _cvvNumberController.text,
        );
        ref.read(balanceProvider.notifier).addBalance(addBalanceRequest);
      } else {
        RemoveBalanceRequest removeBalanceRequest = RemoveBalanceRequest(
          cardNum: _cardNumberController.text,
          amount: double.parse(_amountController.text),
          cvv: _cvvNumberController.text,
        );
        ref.read(balanceProvider.notifier).removeBalance(removeBalanceRequest);
      }
    }
  }

  Widget _buildBalance() {
    final state = ref.watch(balanceProvider);
    if (state is BalanceInitialState) {
      return Container();
    } else if (state is BalanceLoadingState) {
      return CircularProgressIndicator();
    } else if (state is BalanceErrorState) {
      return MyErrorWidget(
        failure: (state as BalanceErrorState).failure,
        onRetry: ref.read(balanceProvider.notifier).getBalance,
      );
    } else {
      final currentState = state as BalanceLoadedState;
      double balance = currentState.balance;
      return Text(
        "Balance:   \$${balance.toStringAsFixed(2)}",
        style: Theme.of(context).textTheme.headline5,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            } else if (ref.watch(balanceAmountProvider) == null) {
              return "couldn't fetch the balance";
            } else if ((_transactionType == TransactionType.withdraw &&
                ref.watch(balanceAmountProvider)! - double.parse(s) < 0)) {
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
              child: _buildBalance(),
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
                        onPressed: submitRequest,
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
