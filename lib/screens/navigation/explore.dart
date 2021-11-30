import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/screens/explore/purshace_item.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

Future<void> _onRefresh() async {}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _onRefresh,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 0),
        child: GridView.builder(
          itemCount: 7,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (MediaQuery.of(context).size.width / 2) /
                  (MediaQuery.of(context).size.height / 3),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16.0),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PurchaseItemScreen(),
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
                            height: (MediaQuery.of(context).size.height / 7),
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
                          Text('seller',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14)),
                          const SizedBox(height: 5),
                          Text(
                            'Item Name',
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text('Price',
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
        ),
      ),
    ));
  }
}
