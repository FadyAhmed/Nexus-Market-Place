import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/providers/users_provider.dart';
import 'package:ds_market_place/screens/account_info/account_info/acc_info_containre.dart';
import 'package:ds_market_place/screens/account_info/reports_screens/reports_container.dart';
import 'package:ds_market_place/screens/account_info/wallet.dart';
import 'package:ds_market_place/screens/navigation/inventory.dart';
import 'package:ds_market_place/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false)
        .getMyProfile(notifyWhenLoaded: false);
  }

  @override
  Widget build(BuildContext context) {
    UsersProvider usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Container(
              padding: const EdgeInsets.only(top: 16, left: 25),
              height: 130,
              color: Theme.of(context).primaryColor,
              child: usersProvider.profileLoadingStatus == LoadingStatus.loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    )
                  : Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              usersProvider.profile!.firstName +
                                  ' ' +
                                  usersProvider.profile!.lastName,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                    Icons.account_balance_wallet_outlined),
                                Text(
                                  " " +
                                      "${usersProvider.profile!.balance.toStringAsFixed(2)}\$",
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
        body: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: ListView(
            children: [
              itemTile(
                context,
                title: "Account Info",
                icon: Icons.account_box,
                handler: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => AccountInfoContainer()))
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
              ),
              itemTile(
                context,
                title: "Log Out",
                icon: Icons.supervised_user_circle_rounded,
                handler: () {
                  globals.token = null;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx) => WelcomeScreen()),
                    (Route route) => false,
                  );
                },
              )
            ],
          ),
        ));
  }
}
