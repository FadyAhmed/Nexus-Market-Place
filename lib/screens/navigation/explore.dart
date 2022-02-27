import 'package:ds_market_place/components/UI/my_cached_img.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/screens/explore/purchase_item.dart';
import 'package:ds_market_place/states/explore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  Widget _buildGrid(List<StoreItem> items) {
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (MediaQuery.of(context).size.width / 2) /
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
                      Text('\$ ' + item.price.toStringAsFixed(2),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildState(ExploreState state) {
    return Center(
      child: Builder(
        builder: (context) {
          if (state is ExploreInitialState) {
            return Container();
          } else if (state is ExploreLoadingState) {
            return CircularProgressIndicator();
          } else if (state is ExploreErrorState) {
            return MyErrorWidget(
              failure: state.failure,
              onRetry: ref
                  .read(exploreProvider.notifier)
                  .getAllStoreItemsFromAllStores,
            );
          } else {
            // loaded state
            final currentState = state as ExploreLoadedState;
            return _buildGrid(currentState.storeItems);
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      ref.read(exploreProvider.notifier).getAllStoreItemsFromAllStores,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh:
            ref.read(exploreProvider.notifier).getAllStoreItemsFromAllStores,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 0),
          child: _buildState(ref.watch(exploreProvider)),
        ),
      ),
    );
  }
}
