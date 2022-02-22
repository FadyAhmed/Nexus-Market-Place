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

  @GET('/api/myinventory/{id}')
  Future<GetInventoryItemResponse> getInventoryItem(@Path() String id);

  // Store Items
  // ===========
  @GET('/api/stores/mystore/{id}')
  Future<GetStoreItemResponse> getStoreItem(@Path() String id);

  @GET('/api/stores/mystore')
  Future<GetAllStoreItemsFromMyStoreResponse> getAllStoreItemsFromMyStore();

  @DELETE('/api/stores/mystore/{id}')
  Future<RemoveItemFromMyStoreResponse> removeStoreItemFromMyStore(
      @Path() String id);

  @POST('/api/stores/mystore/{id}')
  Future<AddItemInMyInventoryToMyStoreResponse> addItemInMyInventoryToMyStore(
      @Path() String id, @Body() AddItemInMyInventoryToMyStoreRequest request);

  @PUT('/api/stores/mystore/{id}')
  Future<EditStoreItemResponse> editStoreItem(
      @Path() String id, @Body() EditStoreItemRequest request);

  @PUT('/api/stores/add/{id}')
  Future<AddItemInOtherStoreToMyStoreResponse> addItemInOtherStoreToMyStore(
      @Path() String id);

  @GET('/api/stores/mystore')
  Future<GetAllStoreItemsFromAllStoresResponse> getAllStoreItemsFromAllStores();

  @GET('/api/stores/{id}')
  Future<GetAllStoreItemsFromParticularStoreResponse>
      getAllStoreItemsFromParticularStore(@Path() String id);

  @GET('/api/stores/search/items')
  Future<SearchStoreItemsResponse> searchStoreItems(@Query('name') String name);

  @PUT('/api/stores/purchase/{id}')
  Future<PurchaseStoreItemResponse> purchaseStoreItem(
      @Path() String id, @Body() PurchaseStoreItemRequest request);
}
