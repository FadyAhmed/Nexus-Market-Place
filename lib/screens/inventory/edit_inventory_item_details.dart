import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:ds_market_place/constants.dart';
import 'package:flutter/material.dart';

class EditInventoryitemDetails extends StatefulWidget {
  @override
  _EditInventoryitemDetailsState createState() =>
      _EditInventoryitemDetailsState();
}

class _EditInventoryitemDetailsState extends State<EditInventoryitemDetails> {
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _price = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _name = TextEditingController(text: "ما وراء الطبيعة");
    _description = TextEditingController(text: "كتاب كدة");
    _amount = TextEditingController(text: "15");
    _price = TextEditingController(text: "200");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<KFormField> fields = [
      KFormField(
          controller: _name,
          hint: 'Item Name',
          label: "Name",
          obsecure: false,
          validator: (text) {
            if (text == null || text.isEmpty) return 'Empty';
          }),
      KFormField(
          controller: _amount,
          hint: 'Enter amount ',
          label: "Amount",
          obsecure: false,
          validator: (String? s) => s == null || s.isEmpty
              ? 'Empty'
              : double.tryParse(s) == null
                  ? 'Not A Number!'
                  : null),
      KFormField(
          controller: _price,
          hint: 'Enter price',
          label: "Price",
          obsecure: false,
          validator: (String? s) => s == null || s.isEmpty
              ? 'Empty'
              : double.tryParse(s) == null
                  ? 'Not A Number!'
                  : null),
      KFormField(
          controller: _description,
          hint: 'Enter description',
          label: "Description",
          obsecure: false,
          validator: (text) {
            return (text!.isEmpty) ? 'Empty' : null;
          }),
    ];

    return Scaffold(
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView(
              children: [
                const SizedBox(height: 5),
                SizedBox(width: 150, height: 150, child: Image.asset(kLogo)),
                const Center(
                    child: Text(
                  "book Name",
                )),
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
                  child: RoundedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          FocusScope.of(context).unfocus();

                          showSnackbar(
                              context, Text("Item edited succeccfully"));

                          Navigator.of(context).pop();
                        });
                      }
                    },
                    title: 'Submit',
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
