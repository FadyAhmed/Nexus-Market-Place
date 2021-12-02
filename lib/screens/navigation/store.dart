import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:ds_market_place/screens/store/select_item_to_sell.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<StoresProvider>(context, listen: false)
        .getAllItemsFromMyStore(notifyWhenLoading: false)
        .catchError((e) {
      showMessageDialogue(context, e.message);
    });
  }

  void submitRemove(String id) async {
    try {
      await Provider.of<StoresProvider>(context, listen: false)
          .removeItemFromMyStore(id);
      showSnackbar(context, Text('Item is removed'));
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    var storesProvider = Provider.of<StoresProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => SelectItemToSellScreen())),
        child: const Icon(Icons.add),
      ),
      body: storesProvider.loadingStatus == LoadingStatus.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: storesProvider.items!.length,
              itemBuilder: (context, index) {
                StoreItem item = storesProvider.items![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemCard(
                    // put another value to get it in menu
                    menuItems: item.state == StoreItemState.imported
                        ? ["Remove"]
                        : ["Edit", "Remove"],
                    itemName: item.name,
                    amount: item.amount.toString(),
                    price: item.price,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              OnSaleItemDetailsScreen(item.toInventoryItem())));
                    },
                    onSelectMenuItem: (choice) {
                      if (choice == "Edit") {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditItemDetails(
                            storeItem: item,
                            submitButtonText: "Edit",
                            onSubmit: () => {
                              //TODO: add edit habdler
                              Navigator.of(context).pop()
                            },
                          ),
                        ));
                      } else {
                        submitRemove(item.id!);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
