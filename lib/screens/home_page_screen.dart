import 'package:ds_market_place/components/UI/bottom_nav_bar.dart';
import 'package:ds_market_place/constants.dart';
import 'package:ds_market_place/screens/navigation/account_info.dart';
import 'package:ds_market_place/screens/navigation/explore.dart';
import 'package:ds_market_place/screens/navigation/inventory.dart';
import 'package:ds_market_place/screens/navigation/store.dart';
import 'package:ds_market_place/screens/search_screen.dart';
import 'package:flutter/material.dart';

class MarketHomePage extends StatefulWidget {
  const MarketHomePage({Key? key}) : super(key: key);

  @override
  State<MarketHomePage> createState() => _MarketHomePageState();
}

class _MarketHomePageState extends State<MarketHomePage> {
  int selectedIndex = 0;
  Widget screen = ExploreScreen();

  void changeScreen(int index) {
    onItemTapped(index);
  }

  void currentScreen(int index) {
    if (index == 0) {
      screen = ExploreScreen();
    }
    if (index == 1) {
      screen = SellScreen();
    }
    if (index == 2) {
      screen = InventoryScreen();
    }
    if (index == 3) {
      screen = AccountInfoScreen(
        navToInventoryScreen: () => changeScreen(2),
      );
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      currentScreen(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      appBar: selectedIndex == 3
          ? null
          : AppBar(
              leading: Image.asset(kLogo),
              centerTitle: true,
              title: Text(
                  "${selectedIndex == 0 ? "Marketplace" : selectedIndex == 1 ? "On Sale Items" : selectedIndex == 2 ? "Inventory" : selectedIndex == 3 ? "Account info" : ""}"),
              actions: [
                IconButton(
                    onPressed: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => SearchScreen()))
                        },
                    icon: const Icon(Icons.search))
              ],
            ),
      bottomNavigationBar: MyBottomNavBar(
          currentIndex: selectedIndex, onItemTapped: onItemTapped),
    );
  }
}
