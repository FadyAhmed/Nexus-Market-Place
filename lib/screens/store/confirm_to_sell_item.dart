import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_market_place/components/UI/my_cached_img.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/view_models/confirm_to_sell_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ConfirmItemToSellScreen extends StatefulWidget {
  final onSubmit;
  final String submitButtonText;
  final InventoryItem item;

  const ConfirmItemToSellScreen({
    Key? key,
    required this.item,
    required this.onSubmit,
    required this.submitButtonText,
  }) : super(key: key);
  @override
  _ConfirmItemToSellScreenState createState() =>
      _ConfirmItemToSellScreenState();
}

class _ConfirmItemToSellScreenState extends State<ConfirmItemToSellScreen> {
  ConfirmToSellItemViewModel confirmToSellItemViewModel = GetIt.I();

  late StreamSubscription isConfirmedSub;
  late StreamSubscription failureSub;

  TextEditingController _amount = TextEditingController();
  TextEditingController _price = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    InventoryItem item = widget.item;
    _amount = TextEditingController(text: '1');
    _price = TextEditingController(text: item.price.toStringAsFixed(2));

    isConfirmedSub = confirmToSellItemViewModel.isConfirmedController.stream
        .listen((isConfirmed) {
      if (isConfirmed) {
        showSnackbar(context, Text('Item is added to store'));
        Navigator.of(context).pop();
      }
    });

    failureSub =
        confirmToSellItemViewModel.failureController.stream.listen((failure) {
      if (failure != null) {
        showMessageDialogue(context, failure.message);
      }
    });
  }

  void submitConfirm() async {
    if (_formKey.currentState!.validate()) {
      int amount = int.parse(_amount.text);
      double price = double.parse(_price.text);
      AddItemInMyInventoryToMyStoreRequest request =
          AddItemInMyInventoryToMyStoreRequest(price: price, amount: amount);
      confirmToSellItemViewModel.addItemInMyInventoryToMyStore(
          widget.item.id!, request);
    }
  }

  @override
  Widget build(BuildContext context) {
    var storesProvider = Provider.of<StoresProvider>(context);
    List<KFormField> fields = [
      KFormField(
          key: 'amount',
          controller: _amount,
          hint: 'Enter amount ',
          label: "Amount",
          obsecure: false,
          validator: (String? s) {
            if (s == null || s.isEmpty) {
              return 'Empty';
            } else if (double.tryParse(s) == null) {
              return 'Not A Number!';
            } else if (double.parse(s) <= 0) {
              return 'Only positive numbers are allowed';
            } else if (double.parse(s) > widget.item.amount) {
              return 'Insufficient amount, max: ' +
                  widget.item.amount.toString();
            } else {
              return null;
            }
          }),
      KFormField(
          key: 'price',
          controller: _price,
          hint: 'Enter price',
          label: "Price",
          obsecure: false,
          validator: (String? s) => s == null || s.isEmpty
              ? 'Empty'
              : double.tryParse(s) == null
                  ? 'Not A Number!'
                  : double.parse(s) <= 0
                      ? 'Only positive numbers are allowed'
                      : null),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.submitButtonText == "Edit"
            ? "Edit Item"
            : "Confirm item details"),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView(
              children: [
                const SizedBox(height: 5),
                SizedBox(
                    width: 150,
                    height: 150,
                    child: MyCachedImg(widget.item.imageLink, 100, 100)),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: fields.map((e) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: myTextFormField(
                              key: e.key,
                              context: context,
                              textInputType: e.textInputType,
                              obsecure: false,
                              hint: e.hint,
                              label: e.label,
                              validator: e.validator,
                              controller: e.controller));
                    }).toList()),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: StreamBuilder<bool>(
                    stream: confirmToSellItemViewModel
                        .confirmingLoadingController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.data ?? false) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return RoundedButton(
                        onPressed: submitConfirm,
                        title: widget.submitButtonText,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
