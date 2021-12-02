import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/screens/explore/purshace_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

Future<void> _onRefresh(BuildContext context) async {
  Provider.of<StoresProvider>(context, listen: false)
      .getAllItemsFromAllStores()
      .catchError((e) {
    showMessageDialogue(context, e.message);
  });
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<StoresProvider>(context, listen: false)
        .getAllItemsFromAllStores(notifyWhenLoading: false)
        .catchError((e) {
      showMessageDialogue(context, e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    var storesProvider = Provider.of<StoresProvider>(context);
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 0),
        child: storesProvider.loadingStatus == LoadingStatus.loading
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: storesProvider.allItems!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (MediaQuery.of(context).size.width / 2) /
                      (MediaQuery.of(context).size.height / 3),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  StoreItem item = storesProvider.allItems![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PurchaseItemScreen(item),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 8),
                                Image.asset(
                                  kLogo,
                                  height:
                                      (MediaQuery.of(context).size.height / 7),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.storeName,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 14)),
                                const SizedBox(height: 5),
                                Text(
                                  item.name,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(item.price.toStringAsFixed(2),
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    ));
  }
}
