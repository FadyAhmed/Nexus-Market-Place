import 'package:ds_market_place/components/UI/circular-loading.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/screens/account_info/account_info/purshaced_items.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/explore/purshace_item.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  TextEditingController _query = TextEditingController();

  void submitSearch(String val) async {
    try {
      await Provider.of<StoresProvider>(context, listen: false)
          .searchAllStores(val);
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  Widget build(BuildContext context) {
    var storesProvider = Provider.of<StoresProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 20,
              color: Colors.white,
            ),
            TextField(
              cursorColor: Colors.black,
              onSubmitted: submitSearch,
              textInputAction: TextInputAction.search,
              controller: _query,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                ),
                prefixIcon: InkWell(
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(15),
                filled: true,
                suffixIcon: InkWell(
                  onTap: () {
                    _query.clear();
                  },
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
                hintText: 'Search for items in all stores here',
              ),
            ),
            Container(
              child: storesProvider.loadingStatus == LoadingStatus.loading
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : storesProvider.searchItems == null
                      ? GreyBar('You can search by item name')
                      : storesProvider.searchItems!.length == 0
                          ? GreyBar("No items found")
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: storesProvider.searchItems!.length,
                              itemBuilder: (context, index) {
                                var item = storesProvider.searchItems![index];
                                return Card(
                                  margin: const EdgeInsets.only(
                                      bottom: 8, left: 8, right: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(children: [
                                      ItemCard(
                                        // menuItems: ["Edit", "Remove"],
                                        sellerName: item.storeName,
                                        showActions: false,
                                        itemName: item.name,
                                        amount: item.amount.toString(),
                                        price: item.price,
                                        imageLink: item.imageLink,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PurchaseItemScreen(item),
                                            ),
                                          );
                                        },
                                        onSelectMenuItem: (choice) {
                                          // if (choice == "Edit") {
                                          //   Navigator.of(context)
                                          //       .push(MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         EditItemDetails(
                                          //       inventoryItem: InventoryItem(
                                          //         name: 'name',
                                          //         amount: 1,
                                          //         price: 1,
                                          //         description: 'description',
                                          //         imageLink: 'imageLink',
                                          //       ),
                                          //       submitButtonText: "Edit",
                                          //       onSubmit: () => {
                                          //         //TODO: add edit habdler
                                          //         Navigator.of(context).pop()
                                          //       },
                                          //     ),
                                          //   ));
                                          // } else {
                                          //   //TODO: remove handler
                                          // }
                                        },
                                      ),
                                    ]),
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
