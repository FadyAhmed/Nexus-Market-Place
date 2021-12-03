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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnSaleItemsScreen extends StatefulWidget {
  const OnSaleItemsScreen({Key? key}) : super(key: key);

  @override
  _OnSaleItemsScreenState createState() => _OnSaleItemsScreenState();
}

class _OnSaleItemsScreenState extends State<OnSaleItemsScreen> {
  Future<void> fetchAllItemsFromMyStore() async {
    try {
      await Provider.of<StoresProvider>(context, listen: false)
          .getAllItemsFromMyStore(notifyWhenLoading: false);
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  void submitDelete(String id) async {
    try {
      await Provider.of<StoresProvider>(context, listen: false)
          .removeItemFromMyStore(id);
      showSnackbar(context, Text('Item is deleted'));
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllItemsFromMyStore();
  }

  @override
  Widget build(BuildContext context) {
    var storeProvider = Provider.of<StoresProvider>(context);
    List<StoreItem>? ownedItems;
    if (storeProvider.items != null)
      ownedItems = storeProvider.items!
          .where((item) => item.state == StoreItemState.owned)
          .toList();
    return Scaffold(
      body: storeProvider.loadingStatus == LoadingStatus.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ownedItems!.length,
              itemBuilder: (context, index) {
                StoreItem item = ownedItems![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemCard(
                    menuItems: ["Edit", "Remove"],
                    itemName: item.name,
                    amount: item.amount.toString(),
                    price: item.price,
                    imageLink: item.imageLink,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OnSaleItemDetailsScreen(storeItem: item))),
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
                        submitDelete(item.id!);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
