import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/providers/inventories_provider.dart';
import 'package:ds_market_place/screens/inventory/add_item_to_inventory.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/store/confirm_to_sell_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectItemToSellScreen extends StatefulWidget {
  const SelectItemToSellScreen({Key? key}) : super(key: key);

  @override
  _SelectItemToInvenSellnState createState() => _SelectItemToInvenSellnState();
}

class _SelectItemToInvenSellnState extends State<SelectItemToSellScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<InventoriesProvider>(context, listen: false)
        .getAllItems(notifyWhenLoading: false)
        .catchError((e) {
      showMessageDialogue(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    var inventoriesProvider = Provider.of<InventoriesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select item to sell"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => AddItemToInventory())),
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          GreyBar('Items on your inventory'),
          Expanded(
            child: inventoriesProvider.loadingStatus == LoadingStatus.loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: inventoriesProvider.items!.length,
                    itemBuilder: (context, index) {
                      var item = inventoriesProvider.items![index];
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ItemCard(
                              menuItems: ["Edit", "Remove"],
                              itemName: item.name,
                              amount: item.amount.toString(),
                              price: item.price,
                              imageLink: item.imageLink,
                              showActions: false,
                              onPressed: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConfirmItemToSellScreen(
                                            item: item,
                                            submitButtonText: "Confirm",
                                            onSubmit: () {
                                              showSnackbar(context,
                                                  Text("Item added to sale"));

                                              Navigator.of(context).pop();
                                            }),
                                  ),
                                );
                              }));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
