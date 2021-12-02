import 'package:ds_market_place/components/UI/rounded_button.dart';
import 'package:ds_market_place/components/UI/show_snackbar.dart';
import 'package:ds_market_place/components/UI/table_row.dart';
import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/screens/explore/store_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseItemScreen extends StatefulWidget {
  final StoreItem item;
  PurchaseItemScreen(this.item, {Key? key}) : super(key: key);

  @override
  _PurchaseItemScreenState createState() => _PurchaseItemScreenState();
}

class _PurchaseItemScreenState extends State<PurchaseItemScreen> {
  // this is dummy
  int amount = 1;
  void _increaseAmount() {
    setState(() {
      amount++;
    });
  }

  void _decreaseAmount() {
    setState(() {
      if (amount - 1 >= 1) amount--;
    });
  }

  void submitAddToMyStore(String id) async {
    try {
      await Provider.of<StoresProvider>(context, listen: false)
          .addAnotherStoreItemToMyStore(id);
      showSnackbar(context, Text("Item added to your store succesfully"));
      Navigator.of(context).pop();
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    var storesProvider = Provider.of<StoresProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  kLogo,
                  width: MediaQuery.of(context).size.width / 3,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Table(
            children: [
              tableRow("Name: ", widget.item.name, context),
              tableRow("", "", context),
              tableRow("Description: ", widget.item.description, context),
              tableRow("", "", context),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Text("Seller: ",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 18,
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => StoreDetailsScreen(
                                storeName: widget.item.storeName,
                                storeId: widget.item.storeId,
                              )));
                    },
                    child: Text(widget.item.storeName,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF487E89),
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ]),
              tableRow("", "", context),
              tableRow(
                  "Available amount: ", widget.item.amount.toString(), context),
              tableRow("", "", context),
              tableRow("Price: ", "\$${widget.item.price.toStringAsFixed(2)}",
                  context),
            ],
          ),
          const SizedBox(height: 50),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                  child: Text("Amount",
                      style: TextStyle(
                          color: Colors.grey.shade700, fontSize: 20))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(title: "-", onPressed: _decreaseAmount),
                  const SizedBox(width: 20),
                  Text(
                    amount.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 20),
                  RoundedButton(title: "+", onPressed: _increaseAmount),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                  width: MediaQuery.of(context).size.width - 120,
                  height: 45,
                  child: RoundedButton(
                      title: "Purchase",
                      onPressed: () {
                        showSnackbar(
                            context, Text("Item purchased succesfully"));
                        Navigator.of(context).pop();
                      })),
              const SizedBox(height: 20),
              Container(
                  width: MediaQuery.of(context).size.width - 120,
                  height: 45,
                  child: storesProvider.loadingStatus == LoadingStatus.loading
                      ? Center(
                          child:
                              CircularProgressIndicator(color: Colors.orange))
                      : RoundedButton(
                          color: Colors.orange,
                          title: "Add To My Store",
                          onPressed: () =>
                              submitAddToMyStore(widget.item.id!))),
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }
}
