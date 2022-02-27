import 'dart:async';

import 'package:ds_market_place/components/UI/my_cached_img.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/text_field.dart';
import 'package:ds_market_place/components/UI/text_form_field_class.dart';
import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/states/item_edit_state.dart';
import 'package:ds_market_place/view_models/edit_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class EditItemDetails extends ConsumerStatefulWidget {
  final onSubmit;
  final String submitButtonText;
  final InventoryItem? inventoryItem;
  final StoreItem? storeItem;

  EditItemDetails({
    Key? key,
    required this.onSubmit,
    required this.submitButtonText,
    this.inventoryItem,
    this.storeItem,
  })  : assert((inventoryItem != null && inventoryItem.id != null) ||
            (storeItem != null && storeItem.id != null)),
        super(key: key);
  @override
  _EditItemDetailsState createState() => _EditItemDetailsState();
}

class _EditItemDetailsState extends ConsumerState<EditItemDetails> {
  TextEditingController _name = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _imageLink = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    ref.refresh(itemEditProvider);

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
      bool isImageValid = await isValidImage(_imageLink.text);
      if (!isImageValid) {
        showMessageDialogue(context,
            'Entered image URL is not a valid image\n\nURLs should begin with http:// or https://');
        return;
      }
      if (widget.inventoryItem != null) {
        EditInventoryItemRequest request = EditInventoryItemRequest(
          name: _name.text,
          amount: int.parse(_amount.text),
          price: double.parse(_price.text),
          description: _description.text,
          imageLink: _imageLink.text,
        );
        ref
            .read(itemEditProvider.notifier)
            .editInventoryItem(widget.inventoryItem!.id!, request);
      } else {
        EditStoreItemRequest request = EditStoreItemRequest(
          name: _name.text,
          price: double.parse(_price.text),
          amount: int.parse(_amount.text),
          imageLink: _imageLink.text,
          description: _description.text,
        );
        ref
            .read(itemEditProvider.notifier)
            .editStoreItem(widget.storeItem!.id!, request);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(itemEditProvider, (previous, next) {
      if (next is ItemEditLoadedState) {
        showSnackbar(context, Text('${_name.text} is edited successfully'));
        Navigator.pop(context);
      }
    });

    List<KFormField> fields = [
      KFormField(
          key: 'name',
          controller: _name,
          hint: 'Item Name',
          label: "Name",
          obsecure: false,
          validator: (text) {
            if (text == null || text.isEmpty) return 'Empty';
          }),
      KFormField(
          key: 'amount',
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
      KFormField(
          key: 'description',
          controller: _description,
          hint: 'Enter description',
          label: "Description",
          obsecure: false,
          validator: (text) {
            return (text!.isEmpty) ? 'Empty' : null;
          }),
      KFormField(
          key: 'link',
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
                    child: MyCachedImg(
                      widget.inventoryItem?.imageLink ??
                          widget.storeItem!.imageLink,
                      150,
                      150,
                    ),
                  ),
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
                    child: Builder(builder: (context) {
                      final button = RoundedButton(
                        onPressed: submitEditItem,
                        title: widget.submitButtonText,
                      );
                      final state = ref.watch(itemEditProvider);
                      if (state is ItemEditInitialState) {
                        return button;
                      } else if (state is ItemEditLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ItemEditErrorState) {
                        return MyErrorWidget(
                          failure: state.failure,
                          onRetry: submitEditItem,
                        );
                      } else {
                        return button;
                      }
                    }),
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
