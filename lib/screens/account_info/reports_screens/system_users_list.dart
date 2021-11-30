import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/components/UI/item_transaction_card.dart';
import 'package:ds_market_place/screens/account_info/reports_screens/user_details.dart';
import 'package:flutter/material.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

const headingStyle = TextStyle(fontSize: 24);

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("System Users List"), centerTitle: true),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child: InkWell(
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>
                      UserDetailsScreen(userName: "Ziad Mostafa")))
            },
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
                child: Center(
                  child: Text(
                    "Ziad Mostafa",
                    textAlign: TextAlign.center,
                    style: headingStyle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
