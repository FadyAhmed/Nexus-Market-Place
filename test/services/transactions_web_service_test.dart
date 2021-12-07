import 'dart:convert';

import 'package:ds_market_place/models/transaction.dart';
import 'package:ds_market_place/services/transactions_web_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks_generator.mocks.dart';

void main() {
  late MockClient client;
  late TransactionsWebService transactionsWebService;

  setUp(() {
    client = MockClient();
    transactionsWebService = TransactionsWebService(client);
  });

  List<Transaction> transactions = [
    Transaction(
      itemName: 'item1',
      price: 1.99,
      amount: 1,
      imageLink: 'link1',
      date: DateTime.now(),
      sellerStoreId: 'storeId1',
      sellerStoreName: 'store1',
      buyerStoreId: 'storeId2',
      buyerStoreName: 'store2',
    ),
  ];
  test('getSoldItems should return a list of transactions if successful',
      () async {
    String body = jsonEncode({
      'success': true,
      'transactions': transactions.map((trans) => trans.toJson()).toList(),
    });
    when(client.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response(body, 200));
    List<Transaction> result = await transactionsWebService.getSoldItems();
    expect(result.first.itemName, transactions.first.itemName);
  });
}
