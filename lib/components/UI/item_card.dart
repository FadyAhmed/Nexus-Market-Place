import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_market_place/components/UI/data_text.dart';
import 'package:ds_market_place/components/UI/my_cached_img.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/states/item_delete_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';

class ItemCard extends StatelessWidget {
  final String itemId;
  final String itemName;
  final String amount;
  final String sellerName;
  final double price;
  final String imageLink;
  final onPressed;
  final onSelectMenuItem;
  final List<String>? menuItems;
  final bool showActions;
  const ItemCard(
      {Key? key,
      required this.itemId,
      required this.itemName,
      required this.amount,
      required this.price,
      required this.imageLink,
      required this.onPressed,
      this.showActions = true,
      this.onSelectMenuItem,
      this.sellerName = "",
      this.menuItems})
      : super(key: key);

  Widget _buildPopUpMenuButton() {
    return Consumer(
      builder: (context, ref, child) {
        // if i put the showDialog code with the logic below, it causes an error
        ref.listen(itemDeleteProvider, (previous, next) {
          if (next is ItemDeleteErrorState && next.deletedItemId == itemId) {
            showMessageDialogue(context, next.failure.message);
          }
        });
        final state = ref.watch(itemDeleteProvider);
        if (state is ItemDeleteInitialState) {
          return child!;
        } else if (state is ItemDeleteLoadingState) {
          // execluding pop up buttons that don't belong to deleted inventory
          // item's item card
          if (state.deletedItemId != itemId) return child!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ItemDeleteErrorState) {
          if (state.deletedItemId != itemId) return child!;
          return child!;
        } else {
          return child!;
        }
      },
      child: PopupMenuButton<String>(
        onSelected: onSelectMenuItem,
        itemBuilder: (BuildContext context) {
          return menuItems!.map((item) {
            return PopupMenuItem<String>(value: item, child: Text(item));
          }).toList();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPressed,
          tileColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.all(16),
          leading: MyCachedImg(imageLink, 100, 100),
          // FutureBuilder(
          //   future: isValidImage(imageLink),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting)
          //       return Center(child: CircularProgressIndicator());
          //     bool isValid = snapshot.data as bool;
          //     if (isValid)
          //       return Image.network(imageLink, fit: BoxFit.scaleDown);
          //     else
          //       return Image.asset(kLogo, fit: BoxFit.scaleDown);
          //   },
          // ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemName,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.normal)),
              const SizedBox(height: 4),
              sellerName != ""
                  ? Text("Seller: $sellerName",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.normal))
                  : Container(),
              sellerName != "" ? const SizedBox(height: 4) : Container(),
              dataText(context, "Amount", amount),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(price.toStringAsFixed(2) + " \$",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.normal)),
              const SizedBox(width: 0),
              showActions && menuItems != null
                  ? _buildPopUpMenuButton()
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
