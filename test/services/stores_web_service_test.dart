import 'dart:convert';

import 'package:ds_market_place/constants/enums.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/services/stores_web_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks_generator.mocks.dart';

void main() {
  late MockClient client;
  late StoresWebService storesWebService;

  setUp(() {
    client = MockClient();
    storesWebService = StoresWebService(client);
  });

  List<StoreItem> items = [
    StoreItem(
      name: 'item1',
      price: 1.99,
      amount: 1,
      imageLink: 'link1',
      description: 'desc1',
      state: StoreItemState.owned,
      storeId: 'storeId1',
      storeName: 'store1',
    ),
  ];
  StoreItem item = StoreItem(
    name: 'item1',
    price: 1.99,
    amount: 1,
    imageLink: 'link1',
    description: 'desc1',
    state: StoreItemState.owned,
    storeId: 'storeId1',
    storeName: 'store1',
  );

  test(
      'getAllItemsFromMyStore should return a list of StoreItems if successful',
      () async {
    String body = jsonEncode({
      'success': true,
      'items': items.map((item) => item.toJson()).toList(),
    });
    when(client.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response(body, 200));
    List<StoreItem> result = await storesWebService.getAllItemsFromMyStore();
    expect(result.first.name, items.first.name);
  });

  test('getItemFromMyStore should return a StoreItem if successful', () async {
    String body = jsonEncode({
      'success': true,
      'item': item.toJson(),
    });
    when(client.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response(body, 200));
    StoreItem result = await storesWebService.getItemFromMyStore('id');
    expect(result.name, item.name);
  });

  test('addInventoryItemToMyStore should return an id when successful',
      () async {
    String body = jsonEncode({
      'success': true,
      'status': 'item added successfully to your store',
      'id': 'storeItemId',
    });
    when(client.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => Response(body, 200));
    expect(
      await storesWebService.addInventoryItemToMyStore(
          id: 'id', price: 1, amount: 1),
      isA<String>(),
    );
  });
}
