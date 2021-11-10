import 'package:ds_market_place/components/UI/table_row.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key, required this.userName}) : super(key: key);
  final String userName;
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.userName),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Table(
          children: [
            tableRow("Name:", widget.userName, context),
            tableRow("", "", context),
            tableRow("Store Name:", "Meg", context),
            tableRow("", "", context),
            tableRow("Email:", "ziad@ziad.com", context),
            tableRow("", "", context),
            tableRow("Phone Number:", "0101556230", context),
            tableRow("", "", context),
            tableRow("Balance:", "\$10000", context)
          ],
        ),
      ),
    );
  }
}
