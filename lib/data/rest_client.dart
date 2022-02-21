import 'package:ds_market_place/data/requests.dart';
import 'package:ds_market_place/data/responses.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://nexus-market.herokuapp.com')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // Inventory Items
  // ===============

  @POST('/api/users/login')
  Future<LoginResponse> signIn(@Body() LoginRequest loginRequest);

  @GET('/api/myinventory')
  Future<GetAllInventoryItemsResponse> getAllInventoryItems();

  @DELETE('/api/myinventory/{id}')
  Future<RemoveInventoryItemResponse> removeInventoryItem(@Path() String id);

  @PUT('/api/myinventory/{id}')
  Future<EditInventoryItemResponse> editInventoryItem(
      @Path() String id, @Body() EditInventoryItemRequest request);

  @POST('/api/myinventory')
  Future<AddInventoryItemResponse> addInventoryItem(
      @Body() AddInventoryItemRequest request);

  // Store Items
  // ===========

  @GET('/api/stores/mystore')
  Future<GetAllStoreItemsFromMyStoreResponse> getAllStoreItemsFromMyStore();

  @DELETE('/api/stores/mystore/{id}')
  Future<RemoveItemFromMyStoreResponse> removeStoreItemFromMyStore(
      @Path() String id);
}
