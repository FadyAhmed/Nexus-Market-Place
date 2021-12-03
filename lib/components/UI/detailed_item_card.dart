import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds_market_place/components/UI/data_text.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class DetailedItemCard extends StatelessWidget {
  final String itemName;
  final String amount;
  final String date;
  final String name;
  final String type;
  final double price;
  final String imageLink;
  const DetailedItemCard({
    Key? key,
    required this.itemName,
    required this.amount,
    required this.price,
    required this.imageLink,
    required this.date,
    required this.name,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.all(16),
          leading: CachedNetworkImage(
            imageUrl: imageLink,
            errorWidget: (context, _, __) => Image.asset(
              kLogo,
              fit: BoxFit.scaleDown,
            ),
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
              dataText(context, "Amount", amount)
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
          leading: SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dataText(
                      context, (type == "SOLD" ? "Buyer" : "Seller"), name),
                ],
              )),
          trailing: dataText(context, "Date", date),
        ),
      ],
    );
  }
}
