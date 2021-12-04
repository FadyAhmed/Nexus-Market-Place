import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_transaction_card.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/user.dart';
import 'package:ds_market_place/providers/users_provider.dart';
import 'package:ds_market_place/screens/account_info/reports_screens/user_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

const headingStyle = TextStyle(fontSize: 24);

class _UsersListScreenState extends State<UsersListScreen> {
  void fetchAllUsers() async {
    try {
      await Provider.of<UsersProvider>(context, listen: false)
          .getAllUsers(notifyWhenLoaded: false);
    } on ServerException catch (e) {
      showMessageDialogue(context, e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    var usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("System Users List"), centerTitle: true),
      body: usersProvider.usersLoadingStatus == LoadingStatus.loading
          ? Center(child: CircularProgressIndicator())
          : usersProvider.users!.length == 0
              ? GreyBar('No users are found in the whole system')
                : ListView.builder(
              itemCount: usersProvider.users!.length,
              itemBuilder: (context, index) {
                User user = usersProvider.users![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12),
                  child: InkWell(
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => UserDetailsScreen(user: user)))
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 24),
                        child: Center(
                          child: Text(
                            user.firstName + ' ' + user.lastName,
                            textAlign: TextAlign.center,
                            style: headingStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
