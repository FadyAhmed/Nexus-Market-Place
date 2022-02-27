import 'package:dio/dio.dart';
import 'package:ds_market_place/components/UI/detailed_item_card.dart';
import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_transaction_card.dart';
import 'package:ds_market_place/components/UI/my_error_widget.dart';
import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/domain/failure.dart';
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/helpers/functions.dart';
import 'package:ds_market_place/models/user.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/providers/users_provider.dart';
import 'package:ds_market_place/screens/account_info/reports_screens/user_details.dart';
import 'package:ds_market_place/view_models/user_reports_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class UsersListScreen extends ConsumerStatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

const headingStyle = TextStyle(fontSize: 24);

class _UsersListScreenState extends ConsumerState<UsersListScreen> {

  Widget buildList(List<User> users) {
    if (users.isEmpty) {
      return GreyBar('No users are found in the whole system.');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("System Users List"), centerTitle: true),
      body: Center(
        child: ref.watch(allUsersProvider).when(
              data: buildList,
              error: (err, _) {
                if (err is DioError) {
                  return MyErrorWidget(
                    failure: err.failure,
                    onRetry: () => ref.refresh(soldItemsProvider),
                  );
                }
              },
              loading: () => CircularProgressIndicator(),
            ),
      ),
    );
  }
}
