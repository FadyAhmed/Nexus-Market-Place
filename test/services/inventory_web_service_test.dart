import 'dart:convert';

import 'package:ds_market_place/constants/routes_constants.dart';
import 'package:ds_market_place/globals.dart' as globals;
import 'package:ds_market_place/helpers/exceptions.dart';
import 'package:ds_market_place/models/inventory_item.dart';
import 'package:ds_market_place/services/inventories_web_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks_generator.mocks.dart';

void main() {
  late MockClient client;
  late InventoriesWebService inventoriesWebService;

  setUp(() {
    client = MockClient();
    inventoriesWebService = InventoriesWebService(client);
  });

  group('addItem method', () {
    InventoryItem item = InventoryItem(
      name: 'item1',
      amount: 1,
      price: 1.99,
      description: 'desc1',
      imageLink: 'link1',
    );
    String newItemId = 'newItemId';
    String addItemBestCaseResponse = jsonEncode({
      'success': true,
      'status': 'item added successfully',
      'id': newItemId,
    });

    test('addItem returns body["id"] if successful', () async {
      when(client.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => Response(addItemBestCaseResponse, 200));

      String result = await inventoriesWebService.addItem(item);
      expect(result, newItemId);
    });

    test('addItem sends suitable "Content-Type" and "Authorization" headers',
        () async {
      when(client.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => Response(addItemBestCaseResponse, 200));
      await inventoriesWebService.addItem(item);
      verify(client.post(Uri.parse(RoutesConstants.addItemToInventory),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${globals.token}',
          },
          body: jsonEncode(item.toJson())));
    });

    test('addItem throws ServerException when body["success"] is false',
        () async {
      String addItemBadResponse =
          jsonEncode({'success': false, 'status': 'invalid token'});
      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => Response(addItemBadResponse, 400));
      expect(() => inventoriesWebService.addItem(item),
          throwsA(isA<ServerException>()));
    });
  });

  group('getAllItems method', () {
    List<InventoryItem> items = [
      InventoryItem(
        name: 'item1',
        amount: 1,
        price: 1.99,
        description: 'desc1',
        imageLink: 'link1',
      ),
      InventoryItem(
        name: 'item2',
        amount: 2,
        price: 2.99,
        description: 'desc2',
        imageLink: 'link2',
      ),
      InventoryItem(
        name: 'item3',
        amount: 3,
        price: 3.99,
        description: 'desc3',
        imageLink: 'link3',
      ),
    ];
    List<Map<String, dynamic>> itemsMapList =
        items.map((item) => item.toJson()).toList();
    String getAllItemsBestCase = jsonEncode({
      'success': true,
      'items': itemsMapList,
    });
    String getAllItemsBadCase = jsonEncode({
      'success': false,
      'status': 'invalid token',
    });
    test(
        'getAllItems returns a list of InventoryItems if body["success"] is true',
        () async {
      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response(getAllItemsBestCase, 200));
      final result = await inventoriesWebService.getAllItems();
      expect(result, isA<List<InventoryItem>>());
      expect(result.first.name, 'item1');
    });

    test('getAllItems sends suitable "Authorization" header with the request',
        () async {
      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response(getAllItemsBestCase, 200));
      await inventoriesWebService.getAllItems();
      verify(client.get(Uri.parse(RoutesConstants.getAllInventoryItems),
          headers: {'Authorization': 'Bearer ${globals.token}'}));
    });

    test('getAllItems throws ServerException when body["success"] is false',
        () async {
      when(client.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response(getAllItemsBadCase, 400));
      expect(
          inventoriesWebService.getAllItems(), throwsA(isA<ServerException>()));
    });
  });
}
