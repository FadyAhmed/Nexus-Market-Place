import 'package:ds_market_place/screens/account_info/account_info/acc_info_containre.dart';
import 'package:ds_market_place/screens/account_info/reports_screens/reports_container.dart';
import 'package:ds_market_place/screens/account_info/wallet.dart';
import 'package:ds_market_place/screens/navigation/inventory.dart';
import 'package:flutter/material.dart';

class AccountInfoScreen extends StatefulWidget {
  final Function navToInventoryScreen;
  const AccountInfoScreen({Key? key, required this.navToInventoryScreen})
      : super(key: key);

  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

ListTile itemTile(BuildContext context,
    {required String title, required IconData icon, required handler}) {
  return ListTile(
      onTap: handler,
      contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      leading: Icon(
        icon,
        size: 33,
        color: Colors.black,
      ),
      title: Row(
        children: [
          const SizedBox(width: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ));
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              height: 130,
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Zoad",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.account_balance_wallet_outlined),
                          Text(
                            " " + "1500\$",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            )),
        body: ListView(
          children: [
            itemTile(
              context,
              title: "Account Info",
              icon: Icons.account_box,
              handler: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => AccountInfoContainer()))
              },
            ),
            itemTile(context,
                title: "Inventory",
                icon: Icons.window,
                handler: widget.navToInventoryScreen),
            itemTile(
              context,
              title: "Wallet",
              icon: Icons.account_balance_wallet_outlined,
              handler: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => WalletScreen()))
              },
            ),
            itemTile(
              context,
              title: "Reports",
              icon: Icons.description,
              handler: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ReportScreenContainer()))
              },
            )
          ],
        ));
  }
}
