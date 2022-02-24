// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://nexus-market.herokuapp.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GetAllInventoryItemsResponse> getAllInventoryItems() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllInventoryItemsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/myinventory',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllInventoryItemsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RemoveInventoryItemResponse> removeInventoryItem(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RemoveInventoryItemResponse>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/myinventory/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RemoveInventoryItemResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EditInventoryItemResponse> editInventoryItem(id, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EditInventoryItemResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/myinventory/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EditInventoryItemResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddInventoryItemResponse> addInventoryItem(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddInventoryItemResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/myinventory',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddInventoryItemResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetInventoryItemResponse> getInventoryItem(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetInventoryItemResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/myinventory/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetInventoryItemResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetStoreItemResponse> getStoreItem(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetStoreItemResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/stores/mystore/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetStoreItemResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllStoreItemsFromMyStoreResponse>
      getAllStoreItemsFromMyStore() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllStoreItemsFromMyStoreResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/stores/mystore',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllStoreItemsFromMyStoreResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RemoveItemFromMyStoreResponse> removeStoreItemFromMyStore(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RemoveItemFromMyStoreResponse>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/stores/mystore/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RemoveItemFromMyStoreResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddItemInMyInventoryToMyStoreResponse> addItemInMyInventoryToMyStore(
      id, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddItemInMyInventoryToMyStoreResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/stores/mystore/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddItemInMyInventoryToMyStoreResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EditStoreItemResponse> editStoreItem(id, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EditStoreItemResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/stores/mystore/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EditStoreItemResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddItemInOtherStoreToMyStoreResponse> addItemInOtherStoreToMyStore(
      id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddItemInOtherStoreToMyStoreResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/stores/add/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddItemInOtherStoreToMyStoreResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllStoreItemsFromAllStoresResponse>
      getAllStoreItemsFromAllStores() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllStoreItemsFromAllStoresResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/stores',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllStoreItemsFromAllStoresResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllStoreItemsFromParticularStoreResponse>
      getAllStoreItemsFromParticularStore(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllStoreItemsFromParticularStoreResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/stores/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        GetAllStoreItemsFromParticularStoreResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchStoreItemsResponse> searchStoreItems(name) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'name': name};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchStoreItemsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/stores/search/items',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchStoreItemsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PurchaseStoreItemResponse> purchaseStoreItem(id, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PurchaseStoreItemResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/stores/purchase/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PurchaseStoreItemResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMySoldItemsResponse> getMySoldItems() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMySoldItemsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/transactions/sold',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMySoldItemsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMyPurchasedItemsResponse> getMyPurchasedItems() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMyPurchasedItemsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/transactions/purchased',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMyPurchasedItemsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllTransactionsResponse> getAllTransactions() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllTransactionsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/transactions',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllTransactionsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignUpResponse> signUp(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SignUpResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/users/signup',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignUpResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponse> signIn(loginRequest) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(loginRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/users/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProfileResponse> getProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ProfileResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/users/profile',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ProfileResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllUsersResponse> getAllUsers() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllUsersResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/users',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllUsersResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddBalanceResponse> addBalance(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddBalanceResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/users/wallet/deposit',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddBalanceResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RemoveBalanceResponse> removeBalance(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RemoveBalanceResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/users/wallet/withdraw',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RemoveBalanceResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
