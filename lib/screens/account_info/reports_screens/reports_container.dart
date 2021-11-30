import 'package:ds_market_place/screens/account_info/reports_screens/system_users_list.dart';
import 'package:ds_market_place/screens/account_info/reports_screens/system_transactions.dart';
import 'package:flutter/material.dart';

class ReportScreenContainer extends StatefulWidget {
  const ReportScreenContainer({Key? key}) : super(key: key);

  @override
  _ReportScreenContainerState createState() => _ReportScreenContainerState();
}

class _ReportScreenContainerState extends State<ReportScreenContainer> {
  Widget card(String title, headingStyle, Widget screen) {
    return InkWell(
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => screen))
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: headingStyle,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var headingStyle = TextStyle(fontSize: 24);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Reports"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            children: [
              card("View System Transactions", headingStyle,
                  SystemTransactionsScreen()),
              const SizedBox(height: 16),
              card("View System Users", headingStyle, UsersListScreen()),
            ],
          ),
        ));
  }
}
