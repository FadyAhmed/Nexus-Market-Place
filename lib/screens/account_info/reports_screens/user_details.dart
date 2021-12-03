import 'package:ds_market_place/components/UI/table_row.dart';
import 'package:ds_market_place/models/user.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user.firstName + ' ' + user.lastName),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Table(
          children: [
            tableRow("Name:", user.firstName + ' ' + user.lastName, context),
            tableRow("", "", context),
            tableRow("Store Name:", user.storeName, context),
            tableRow("", "", context),
            tableRow("Email:", user.email, context),
            tableRow("", "", context),
            tableRow("Phone Number:", user.phoneNumber, context),
            tableRow("", "", context),
            tableRow("Balance:", "\$${user.balance}", context)
          ],
        ),
      ),
    );
  }
}
