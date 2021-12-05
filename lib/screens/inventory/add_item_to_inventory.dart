import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/providers/inventories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddItemToInventory extends StatefulWidget {
  @override
  _AddItemToInventoryState createState() => _AddItemToInventoryState();
}

final _formKey = GlobalKey<FormState>();

class _AddItemToInventoryState extends State<AddItemToInventory> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      bool isImageValid = await isValidImage(_imageUrlController.text);
      if (!isImageValid) {
        showMessageDialogue(context,
            'Entered image URL is not a valid image\n\nURLs should begin with http:// or https://');
        return;
      }
      InventoryItem item = InventoryItem(
        name: _nameController.text,
        amount: int.parse(_amountController.text),
        price: double.parse(_priceController.text),
        description: _descController.text,
        imageLink: _imageUrlController.text,
      );
      await Provider.of<InventoriesProvider>(context, listen: false)
          .addItem(item);

      showSnackbar(context, Text("Item added to inventory"));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var inventoriesProvider = Provider.of<InventoriesProvider>(context);
    List<KFormField> fields = [
      KFormField(
          key: 'name',
          controller: _nameController,
          hint: 'Item Name',
          label: "Name",
          obsecure: false,
          validator: (text) {
            if (text == null || text.isEmpty) return 'Empty';
          }),
      KFormField(
          key: 'amount',
          controller: _amountController,
          hint: 'Enter amount ',
          label: "Amount",
          obsecure: false,
          validator: (String? s) {
            if (s == null || s.isEmpty) {
              return 'Empty';
            } else if (int.tryParse(s) == null) {
              return 'Not A Number!';
            } else if (int.parse(s) <= 0) {
              return 'Only positive amount is allowed';
            } else {
              return null;
            }
          }),
      KFormField(
          key: 'price',
          controller: _priceController,
          hint: 'Enter price',
          label: "Price",
          obsecure: false,
          validator: (String? s) {
            if (s == null || s.isEmpty) {
              return 'Empty';
            } else if (double.tryParse(s) == null) {
              return 'Not A Number!';
            } else if (double.parse(s) <= 0) {
              return 'Only positive price is allowed';
            } else {
              return null;
            }
          }),
      KFormField(
          key: 'description',
          controller: _descController,
          hint: 'Enter description',
          label: "Description",
          obsecure: false,
          validator: (text) {
            return (text!.isEmpty) ? 'Empty' : null;
          }),
      KFormField(
          key: 'link',
          controller: _imageUrlController,
          hint: 'Image Link',
          label: "Image Link",
          obsecure: false,
          validator: (text) {
            if (text == null || text.isEmpty) return 'Empty';
          }),
    ];
    return Scaffold(
      appBar:
          AppBar(title: const Text("Add item to inventory"), centerTitle: true),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
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
                                      key: field.key,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: inventoriesProvider.loadingStatus ==
                              LoadingStatus.loading
                          ? Center(child: CircularProgressIndicator())
                          : RoundedButton(
                              onPressed: submitForm,
                              title: 'Add Item',
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
