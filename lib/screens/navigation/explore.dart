import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/my_cached_img.dart';
import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers/stores_provider.dart';
import 'package:ds_market_place/screens/explore/purshace_item.dart';
import 'package:ds_market_place/view_models/explore_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}


class _ExploreScreenState extends State<ExploreScreen> {
  ExploreViewModel exploreViewModel = GetIt.I();

  @override
  void initState() {
    super.initState();
    exploreViewModel.getAllStoreItemsFromAllStores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: exploreViewModel.getAllStoreItemsFromAllStores,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 0),
        child: StreamBuilder<Failure>(
          stream: exploreViewModel.failureController.stream,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Center(child: Text(snapshot.data!.message));
            }
            return StreamBuilder<bool>(
              stream: exploreViewModel.gettingLoadingController.stream,
              builder: (context, snapshot) {
                if (snapshot.data ?? false) {
                  return Center(child: CircularProgressIndicator());
                }
                return StreamBuilder<List<StoreItem>>(
                  stream: exploreViewModel.storeItemsController.stream,
                  builder: (context, snapshot) {
                    List<StoreItem>? items = snapshot.data;
                    if (items == null || items.isEmpty) {
                      return GreyBar('No items found in your store.');
                    }
                    return GridView.builder(
                      itemCount: items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:
                            (MediaQuery.of(context).size.width / 2) /
                                (MediaQuery.of(context).size.height / 3),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        StoreItem item = items[index];
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
                                      MyCachedImg(item.imageLink, 100, 100),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                          '\$ ' + item.price.toStringAsFixed(2),
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    ));
  }
}
