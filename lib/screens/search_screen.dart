import 'package:ds_market_place/components/UI/grey_bar.dart';
import 'package:ds_market_place/components/UI/item_card.dart';
import 'package:ds_market_place/models/store_item.dart';
import 'package:ds_market_place/providers.dart';
import 'package:ds_market_place/screens/explore/purchase_item.dart';
import 'package:ds_market_place/view_models/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  SearchViewModel searchViewModel = GetIt.I();

  final TextEditingController _termController = TextEditingController();
  String? _errorText;
  late List<StoreItem> storeItems;

  void submitSearch() async {
    if (_validator(_termController.text)) {
      setState(() {
        storeItems = ref
            .watch(exploreProvider.notifier)
            .searchItemsInState(_termController.text);
      });
    }
  }

  bool _validator(String searchTerm) {
    if (searchTerm.isEmpty) {
      setState(() => _errorText = 'Enter an item name');
      return false;
    }
    if (searchTerm.contains('.') || searchTerm.contains('\$')) {
      setState(() => _errorText = '\'\$\' and \'.\' symbols are not allowed');
      return false;
    }
    List<String> prohibitedSymbols = ['()', '(', ')', '*', '['];
    for (var symbol in prohibitedSymbols) {
      if (searchTerm == symbol) {
        setState(() {
          _errorText = "Can't use any of these symbols: () * ) [ (";
        });
        return false;
      }
    }
    setState(() => _errorText = null);
    return true;
  }

  Widget _buildList() {
    if (_termController.text.isEmpty) {
      return GreyBar('You can search by item name');
    }
    if (storeItems.isEmpty) {
      return GreyBar('No items were found');
    }
    return ListView.builder(
      padding: const EdgeInsets.all(5.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: storeItems.length,
      itemBuilder: (context, index) {
        var item = storeItems[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(children: [
              ItemCard(
                itemId: item.id!,
                sellerName: item.storeName,
                showActions: false,
                itemName: item.name,
                amount: item.amount.toString(),
                price: item.price,
                imageLink: item.imageLink,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PurchaseItemScreen(item),
                    ),
                  );
                },
              ),
            ]),
          ),
        );
      },
    );
  }

  TextField _buildTextField() {
    return TextField(
      onChanged: (_) => submitSearch(),
      cursorColor: Colors.black,
      textInputAction: TextInputAction.search,
      controller: _termController,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 2.0),
        ),
        errorStyle: TextStyle(fontSize: 16),
        prefixIcon: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(15),
        filled: true,
        suffixIcon: InkWell(
          onTap: () {
            _termController.clear();
          },
          child: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        hintText: 'Search for items in all stores here',
        errorText: _errorText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(exploreProvider, (_, __) => submitSearch());
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 20,
              color: Colors.white,
            ),
            _buildTextField(),
            _buildList(),
          ],
        ),
      ),
    );
  }
}
