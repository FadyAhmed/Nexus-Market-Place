import 'package:ds_market_place/components/UI/data_text.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ItemCard extends StatelessWidget {
  final String itemName;
  final String amount;
  final String sellerName;
  final int price;
  final onPressed;
  final onSelectMenuItem;
  final List<String>? menuItems;
  final bool showActions;
  const ItemCard(
      {Key? key,
      required this.itemName,
      required this.amount,
      required this.price,
      required this.onPressed,
      this.showActions = true,
      this.onSelectMenuItem,
      this.sellerName = "",
      this.menuItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onPressed,
          tileColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.all(16),
          leading: Image.asset(
            kLogo,
            fit: BoxFit.scaleDown,
          ),
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
                  ? PopupMenuButton<String>(
                      onSelected: onSelectMenuItem,
                      itemBuilder: (BuildContext context) {
                        return menuItems!.map((item) {
                          return PopupMenuItem<String>(
                              value: item, child: Text(item));
                        }).toList();
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
