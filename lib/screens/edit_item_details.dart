import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers/inventories_provider.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditItemDetails extends StatefulWidget {
  final onSubmit;
  final String submitButtonText;
  final InventoryItem? inventoryItem;
  final StoreItem? storeItem;

  const EditItemDetails({
    Key? key,
    required this.onSubmit,
    required this.submitButtonText,
    this.inventoryItem,
    this.storeItem,
  })  : assert(inventoryItem != null || storeItem != null),
        super(key: key);
  @override
  _EditItemDetailsState createState() => _EditItemDetailsState();
}

class _EditItemDetailsState extends State<EditItemDetails> {
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _imageLink = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.inventoryItem != null) {
      var item = widget.inventoryItem;
      _name = TextEditingController(text: item!.name);
      _description = TextEditingController(text: item.description);
      _amount = TextEditingController(text: item.amount.toString());
      _price = TextEditingController(text: item.price.toStringAsFixed(2));
      _imageLink = TextEditingController(text: item.imageLink);
    } else {
      var item = widget.storeItem;
      _name = TextEditingController(text: item!.name);
      _description = TextEditingController(text: item.description);
      _amount = TextEditingController(text: item.amount.toString());
      _price = TextEditingController(text: item.price.toStringAsFixed(2));
      _imageLink = TextEditingController(text: item.imageLink);
    }
    super.initState();
  }

  void submitEditItem() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (widget.inventoryItem != null) {
          InventoryItem item = InventoryItem(
            id: widget.inventoryItem!.id,
            name: _name.text,
            amount: int.parse(_amount.text),
            price: double.parse(_price.text),
            description: _description.text,
            imageLink: _imageLink.text,
          );
          await Provider.of<InventoriesProvider>(context, listen: false)
              .editItem(item);
        } else {
          StoreItem item = StoreItem(
            id: widget.storeItem!.id,
            name: _name.text,
            price: double.parse(_price.text),
            amount: int.parse(_amount.text),
            imageLink: _imageLink.text,
            description: _description.text,
            state: widget.storeItem!.state,
            storeId: widget.storeItem!.storeId,
            storeName: widget.storeItem!.storeName,
          );
          await Provider.of<StoresProvider>(context, listen: false)
              .editItemInMyStore(item);
        }
        showSnackbar(context, Text("Item edited successfully"));
        Navigator.of(context).pop();
      } on ServerException catch (e) {
        showMessageDialogue(context, e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var inventoriesProvider = Provider.of<InventoriesProvider>(context);
    var storesProvider = Provider.of<StoresProvider>(context);
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
                  : double.parse(s) <= 0
                      ? 'Only positive numbers are allowed'
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
                  : double.parse(s) <= 0
                      ? 'Only positive numbers are allowed'
                      : null),
      KFormField(
          controller: _description,
          hint: 'Enter description',
          label: "Description",
          obsecure: false,
          validator: (text) {
            return (text!.isEmpty) ? 'Empty' : null;
          }),
      KFormField(
          controller: _imageLink,
          hint: 'Image Link',
          label: "Image Link",
          obsecure: false,
          validator: (text) {
            if (text == null || text.isEmpty) return 'Empty';
          }),
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
                    child: inventoriesProvider.loadingStatus ==
                                LoadingStatus.loading ||
                            storesProvider.loadingStatus ==
                                LoadingStatus.loading
                        ? Center(child: CircularProgressIndicator())
                        : RoundedButton(
                            onPressed: submitEditItem,
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
