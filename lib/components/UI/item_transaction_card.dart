import 'package:flutter/material.dart';

import '../../constants.dart';

class ItemTransactioinCard extends StatelessWidget {
  final String itemName;
  final String amount;
  final String date;
  final String sellerName;
  final String buyerName;
  final String type;
  final String reason;
  final int price;
  const ItemTransactioinCard({
    Key? key,
    required this.itemName,
    required this.amount,
    required this.price,
    required this.date,
    required this.sellerName,
    required this.buyerName,
    required this.type,
    this.reason = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.all(16),
          leading: Image.asset(
            kLogo,
            fit: BoxFit.scaleDown,
            width: 100,
            height: 150,
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
            ],
          ),
        ),
        ListTile(
          tileColor: Theme.of(context).cardColor,
          title: SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Seller: $sellerName",
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Buyer: $buyerName",
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 10),
                  type == "Failed"
                      ? Text(
                          "Reason: $reason",
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      : const Text(""),
                  const SizedBox(height: 10),
                ],
              )),
          trailing: Text("Date: $date",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }
}
