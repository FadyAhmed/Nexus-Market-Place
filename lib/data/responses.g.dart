// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
      token: json['token'] as String,
      admin: json['admin'] as bool,
      storeName: json['storeName'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'token': instance.token,
      'admin': instance.admin,
      'storeName': instance.storeName,
    };

GetAllInventoryItemsResponse _$GetAllInventoryItemsResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllInventoryItemsResponse(
      success: json['success'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => ItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllInventoryItemsResponseToJson(
        GetAllInventoryItemsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'items': instance.items,
    };

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) => ItemResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
      'imageLink': instance.imageLink,
      'description': instance.description,
    };

RemoveInventoryItemResponse _$RemoveInventoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    RemoveInventoryItemResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$RemoveInventoryItemResponseToJson(
        RemoveInventoryItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

EditInventoryItemResponse _$EditInventoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    EditInventoryItemResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$EditInventoryItemResponseToJson(
        EditInventoryItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

AddInventoryItemResponse _$AddInventoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    AddInventoryItemResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$AddInventoryItemResponseToJson(
        AddInventoryItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'id': instance.id,
    };

GetInventoryItemResponse _$GetInventoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    GetInventoryItemResponse(
      success: json['success'] as bool,
      item:
          InventoryItemResponse.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetInventoryItemResponseToJson(
        GetInventoryItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'item': instance.item,
    };

InventoryItemResponse _$InventoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    InventoryItemResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$InventoryItemResponseToJson(
        InventoryItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
      'imageLink': instance.imageLink,
      'description': instance.description,
    };

GetAllStoreItemsFromMyStoreResponse
    _$GetAllStoreItemsFromMyStoreResponseFromJson(Map<String, dynamic> json) =>
        GetAllStoreItemsFromMyStoreResponse(
          success: json['success'] as bool,
          items: (json['items'] as List<dynamic>)
              .map((e) => StoreItemResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetAllStoreItemsFromMyStoreResponseToJson(
        GetAllStoreItemsFromMyStoreResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'items': instance.items,
    };

StoreItemResponse _$StoreItemResponseFromJson(Map<String, dynamic> json) =>
    StoreItemResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      description: json['description'] as String,
      state: $enumDecode(_$StoreItemStateEnumMap, json['state']),
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
    );

Map<String, dynamic> _$StoreItemResponseToJson(StoreItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
      'imageLink': instance.imageLink,
      'description': instance.description,
      'state': _$StoreItemStateEnumMap[instance.state],
      'storeId': instance.storeId,
      'storeName': instance.storeName,
    };

const _$StoreItemStateEnumMap = {
  StoreItemState.owned: 'owned',
  StoreItemState.imported: 'imported',
};

RemoveItemFromMyStoreResponse _$RemoveItemFromMyStoreResponseFromJson(
        Map<String, dynamic> json) =>
    RemoveItemFromMyStoreResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$RemoveItemFromMyStoreResponseToJson(
        RemoveItemFromMyStoreResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

AddItemInMyInventoryToMyStoreResponse
    _$AddItemInMyInventoryToMyStoreResponseFromJson(
            Map<String, dynamic> json) =>
        AddItemInMyInventoryToMyStoreResponse(
          success: json['success'] as bool,
          status: json['status'] as String,
          id: json['id'] as String,
        );

Map<String, dynamic> _$AddItemInMyInventoryToMyStoreResponseToJson(
        AddItemInMyInventoryToMyStoreResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'id': instance.id,
    };

GetStoreItemResponse _$GetStoreItemResponseFromJson(
        Map<String, dynamic> json) =>
    GetStoreItemResponse(
      success: json['success'] as bool,
      item: StoreItemResponse.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetStoreItemResponseToJson(
        GetStoreItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'item': instance.item,
    };

EditStoreItemResponse _$EditStoreItemResponseFromJson(
        Map<String, dynamic> json) =>
    EditStoreItemResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$EditStoreItemResponseToJson(
        EditStoreItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

AddItemInOtherStoreToMyStoreResponse
    _$AddItemInOtherStoreToMyStoreResponseFromJson(Map<String, dynamic> json) =>
        AddItemInOtherStoreToMyStoreResponse(
          success: json['success'] as bool,
          status: json['status'] as String,
          item:
              StoreItemResponse.fromJson(json['item'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$AddItemInOtherStoreToMyStoreResponseToJson(
        AddItemInOtherStoreToMyStoreResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'item': instance.item,
    };

GetAllStoreItemsFromAllStoresResponse
    _$GetAllStoreItemsFromAllStoresResponseFromJson(
            Map<String, dynamic> json) =>
        GetAllStoreItemsFromAllStoresResponse(
          success: json['success'] as bool,
          items: (json['items'] as List<dynamic>)
              .map((e) => StoreItemWithoutStateResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetAllStoreItemsFromAllStoresResponseToJson(
        GetAllStoreItemsFromAllStoresResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'items': instance.items,
    };

StoreItemWithoutStateResponse _$StoreItemWithoutStateResponseFromJson(
        Map<String, dynamic> json) =>
    StoreItemWithoutStateResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      description: json['description'] as String,
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
    );

Map<String, dynamic> _$StoreItemWithoutStateResponseToJson(
        StoreItemWithoutStateResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
      'imageLink': instance.imageLink,
      'description': instance.description,
      'storeId': instance.storeId,
      'storeName': instance.storeName,
    };

GetAllStoreItemsFromParticularStoreResponse
    _$GetAllStoreItemsFromParticularStoreResponseFromJson(
            Map<String, dynamic> json) =>
        GetAllStoreItemsFromParticularStoreResponse(
          success: json['success'] as bool,
          items: (json['items'] as List<dynamic>)
              .map((e) => StoreItemResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetAllStoreItemsFromParticularStoreResponseToJson(
        GetAllStoreItemsFromParticularStoreResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'items': instance.items,
    };

SearchStoreItemsResponse _$SearchStoreItemsResponseFromJson(
        Map<String, dynamic> json) =>
    SearchStoreItemsResponse(
      success: json['success'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              StoreItemWithoutStateResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchStoreItemsResponseToJson(
        SearchStoreItemsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'items': instance.items,
    };

PurchaseStoreItemResponse _$PurchaseStoreItemResponseFromJson(
        Map<String, dynamic> json) =>
    PurchaseStoreItemResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$PurchaseStoreItemResponseToJson(
        PurchaseStoreItemResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'id': instance.id,
    };

GetMySoldItemsResponse _$GetMySoldItemsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMySoldItemsResponse(
      success: json['success'] as bool,
      transactionResponses: (json['transactions'] as List<dynamic>)
          .map((e) =>
              SellTransactionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMySoldItemsResponseToJson(
        GetMySoldItemsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'transactions': instance.transactionResponses,
    };

SellTransactionResponse _$SellTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    SellTransactionResponse(
      itemName: json['itemName'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      date: DateTime.parse(json['date'] as String),
      buyerStoreId: json['buyerStoreId'] as String,
      buyerStoreName: json['buyerStoreName'] as String,
    );

Map<String, dynamic> _$SellTransactionResponseToJson(
        SellTransactionResponse instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'price': instance.price,
      'amount': instance.amount,
      'imageLink': instance.imageLink,
      'date': instance.date.toIso8601String(),
      'buyerStoreId': instance.buyerStoreId,
      'buyerStoreName': instance.buyerStoreName,
    };

PurchaseTransactionResponse _$PurchaseTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    PurchaseTransactionResponse(
      itemName: json['itemName'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      date: DateTime.parse(json['date'] as String),
      sellerStoreId: json['sellerStoreId'] as String,
      sellerStoreName: json['sellerStoreName'] as String,
    );

Map<String, dynamic> _$PurchaseTransactionResponseToJson(
        PurchaseTransactionResponse instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'price': instance.price,
      'amount': instance.amount,
      'imageLink': instance.imageLink,
      'date': instance.date.toIso8601String(),
      'sellerStoreId': instance.sellerStoreId,
      'sellerStoreName': instance.sellerStoreName,
    };

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    TransactionResponse(
      itemName: json['itemName'] as String,
      price: (json['price'] as num).toDouble(),
      amount: json['amount'] as int,
      imageLink: json['imageLink'] as String,
      date: DateTime.parse(json['date'] as String),
      sellerStoreId: json['sellerStoreId'] as String,
      sellerStoreName: json['sellerStoreName'] as String,
      buyerStoreId: json['buyerStoreId'] as String,
      buyerStoreName: json['buyerStoreName'] as String,
    );

Map<String, dynamic> _$TransactionResponseToJson(
        TransactionResponse instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'price': instance.price,
      'amount': instance.amount,
      'imageLink': instance.imageLink,
      'date': instance.date.toIso8601String(),
      'sellerStoreId': instance.sellerStoreId,
      'sellerStoreName': instance.sellerStoreName,
      'buyerStoreId': instance.buyerStoreId,
      'buyerStoreName': instance.buyerStoreName,
    };

GetMyPurchasedItemsResponse _$GetMyPurchasedItemsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyPurchasedItemsResponse(
      success: json['success'] as bool,
      transactionResponses: (json['transactions'] as List<dynamic>)
          .map((e) =>
              PurchaseTransactionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyPurchasedItemsResponseToJson(
        GetMyPurchasedItemsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'transactions': instance.transactionResponses,
    };

GetAllTransactionsResponse _$GetAllTransactionsResponseFromJson(
        Map<String, dynamic> json) =>
    GetAllTransactionsResponse(
      success: json['success'] as bool,
      transactionResponses: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllTransactionsResponseToJson(
        GetAllTransactionsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'transactions': instance.transactionResponses,
    };

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      success: json['success'] as bool,
      user: MiniUserResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'user': instance.user,
    };

MiniUserResponse _$MiniUserResponseFromJson(Map<String, dynamic> json) =>
    MiniUserResponse(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      balance: (json['balance'] as num).toDouble(),
    );

Map<String, dynamic> _$MiniUserResponseToJson(MiniUserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'balance': instance.balance,
    };

GetAllUsersResponse _$GetAllUsersResponseFromJson(Map<String, dynamic> json) =>
    GetAllUsersResponse(
      success: json['success'] as bool,
      userResponses: (json['users'] as List<dynamic>)
          .map((e) => CompleteUserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllUsersResponseToJson(
        GetAllUsersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'users': instance.userResponses,
    };

CompleteUserResponse _$CompleteUserResponseFromJson(
        Map<String, dynamic> json) =>
    CompleteUserResponse(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      storeName: json['storeName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      balance: (json['balance'] as num).toDouble(),
    );

Map<String, dynamic> _$CompleteUserResponseToJson(
        CompleteUserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'storeName': instance.storeName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'balance': instance.balance,
    };

AddBalanceResponse _$AddBalanceResponseFromJson(Map<String, dynamic> json) =>
    AddBalanceResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$AddBalanceResponseToJson(AddBalanceResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

RemoveBalanceResponse _$RemoveBalanceResponseFromJson(
        Map<String, dynamic> json) =>
    RemoveBalanceResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$RemoveBalanceResponseToJson(
        RemoveBalanceResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };
