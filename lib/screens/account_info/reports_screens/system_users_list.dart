import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_transaction_card.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/user.dart';
import 'package:ds_market_place/providers/users_provider.dart';
import 'package:ds_market_place/screens/account_info/reports_screens/user_details.dart';
import 'package:ds_market_place/view_models/user_reports_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

const headingStyle = TextStyle(fontSize: 24);

class _UsersListScreenState extends State<UsersListScreen> {
  UsersReportsViewModel usersReportsViewModel = GetIt.I();

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
    usersReportsViewModel.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("System Users List"), centerTitle: true),
      body: StreamBuilder<Failure?>(
        stream: usersReportsViewModel.failureController.stream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Center(
              child: MyErrorWidget(
                failure: snapshot.data!,
                onRetry: usersReportsViewModel.getAllUsers,
              ),
            );
          }
          return StreamBuilder<bool>(
            stream: usersReportsViewModel.loadingController.stream,
            builder: (context, snapshot) {
              if (snapshot.data ?? false) {
                return Center(child: CircularProgressIndicator());
              }
              return StreamBuilder<List<User>>(
                stream: usersReportsViewModel.usersController.stream,
                builder: (context, snapshot) {
                  List<User>? users = snapshot.data;
                  if (users == null || users.isEmpty) {
                    return GreyBar('No users are found in the whole system.');
                  }
                  return buildList(users);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget buildList(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        User user = users[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child: InkWell(
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => UserDetailsScreen(user: user)))
            },
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
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
    );
  }
}
