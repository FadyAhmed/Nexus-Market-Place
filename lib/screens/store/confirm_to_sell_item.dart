import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:flutter/material.dart';
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
  TextEditingController _amount = TextEditingController();
  TextEditingController _price = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    InventoryItem item = widget.item;
    _amount = TextEditingController(text: '1');
    _price = TextEditingController(text: item.price.toStringAsFixed(2));
    super.initState();
  }

  void submitConfirm() async {
    if (_formKey.currentState!.validate()) {
      int amount = int.parse(_amount.text);
      double price = double.parse(_price.text);
      try {
        await Provider.of<StoresProvider>(context, listen: false)
            .addInventoryItemToMyStore(
          id: widget.item.id!,
          amount: amount,
          price: price,
        );
        showSnackbar(context, Text('Item is added to store'));
        Navigator.of(context).pop();
      } on ServerException catch (e) {
        showMessageDialogue(context, e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var storesProvider = Provider.of<StoresProvider>(context);
    List<KFormField> fields = [
      KFormField(
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
      body: Container(
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListView(
                children: [
                  const SizedBox(height: 5),
                  Container(
                      width: 150,
                      height: 150,
                      child: Image.asset(kLogo, height: 100)),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: fields.map((e) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: myTextFormField(
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
                    child: storesProvider.loadingStatus == LoadingStatus.loading
                        ? Center(child: CircularProgressIndicator())
                        : RoundedButton(
                            onPressed: submitConfirm,
                            title: widget.submitButtonText,
                          ),
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
