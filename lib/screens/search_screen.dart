import 'package:ds_market_place/components/UI/circular-loading.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/screens/account_info/account_info/purshaced_items.dart';
import 'package:ds_market_place/screens/edit_item_details.dart';
import 'package:ds_market_place/screens/seller_item_details.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  TextEditingController _query = TextEditingController();

  Widget build(BuildContext context) {
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
              onSubmitted: (val) {
                setState(() {});
              },
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
                hintText: 'Search Here',
              ),
            ),
            Container(
              child: FutureBuilder(
                future: Future.delayed(Duration.zero),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return loading();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (!snapshot.hasData) {
                      return Text(_query.text.isEmpty ? '' : 'No Data Found!!');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var item = snapshot.data[index];
                          return snapshot.data.length == 0
                              ? const Text('No Data Found!!')
                              : Card(
                                  margin: const EdgeInsets.only(
                                      bottom: 8, left: 8, right: 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Column(children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PurchasedItemsScreen(),
                                            ),
                                          );
                                        },
                                        child: ItemCard(
                                          sellerName: "FATOO",
                                          showActions: false,
                                          itemName: "item name",
                                          amount: "11",
                                          price: 15,
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OnSaleItemDetailsScreen()));
                                          },
                                          onSelectMenuItem: (choice) {
                                            if (choice == "Edit") {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    EditItemDetails(
                                                  submitButtonText: "Edit",
                                                  onSubmit: () => {
                                                    //TODO: add edit habdler
                                                    Navigator.of(context).pop()
                                                  },
                                                ),
                                              ));
                                            } else {
                                              //TODO: remove handler
                                            }
                                          },
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                        },
                      );
                    }
                  } else {
                    return const Text('');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
