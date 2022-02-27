import 'package:dio/dio.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/models/profile.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/screens/account_info/account_info/acc_info_containre.dart';
import 'package:ds_market_place/screens/account_info/reports_screens/reports_container.dart';
import 'package:ds_market_place/screens/account_info/wallet.dart';
import 'package:ds_market_place/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountInfoScreen extends ConsumerStatefulWidget {
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

class _AccountInfoScreenState extends ConsumerState<AccountInfoScreen> {
  Widget buildProfile(BuildContext context, Profile profile) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile.firstName + ' ' + profile.lastName,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.account_balance_wallet_outlined),
                Text(
                  " "
                  "${ref.watch(balanceAmountProvider)?.toStringAsFixed(2) ?? profile.balance.toStringAsFixed(2)}\$",
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Container(
            padding: const EdgeInsets.only(top: 16, left: 25),
            height: 130,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: ref.watch(accountInfoProvider).when(
                    data: (profile) => buildProfile(context, profile),
                    error: (err, errStack) {
                      if (err is DioError) {
                        return MyErrorWidget(
                          failure: err.failure,
                          onRetry: () => ref.refresh(accountInfoProvider),
                        );
                      }
                    },
                    loading: () => CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  ),
            ),
          ),
        ),
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
              if (globals.admin)
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
