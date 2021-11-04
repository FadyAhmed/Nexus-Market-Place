import 'package:flutter/material.dart';

class MyBottomNavBar extends StatefulWidget {
  int currentIndex = 0;
  final Function onItemTapped;
  MyBottomNavBar(
      {Key? key, required this.currentIndex, required this.onItemTapped})
      : super(key: key);

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  static const bottomItemColor = Color(0xff757575);
  static const selectedItemTextColor = Color(0xff757575);

  TextStyle _textStyle(int index) {
    return TextStyle(
      color: (index != widget.currentIndex)
          ? bottomItemColor
          : selectedItemTextColor,
      fontWeight:
          (index != widget.currentIndex) ? FontWeight.w400 : FontWeight.bold,
      fontSize: 16,
    );
  }

  BottomNavigationBarItem _bottomItemContainer(
      String title, int index, var selectedItemColor) {
    return BottomNavigationBarItem(
      tooltip: '',
      icon: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color:
                widget.currentIndex == index ? selectedItemColor : Colors.white,
            borderRadius: const BorderRadius.all(Radius.elliptical(5, 20))),
        child: Text(
          title,
          style: _textStyle(index),
        ),
      ),
      label: "",
    );
  }

  @override
  Widget build(BuildContext context) {
    var selectedItemColor = Theme.of(context).primaryColor;
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 0,
      type: BottomNavigationBarType.shifting,
      items: <BottomNavigationBarItem>[
        _bottomItemContainer("Explore", 0, selectedItemColor),
        _bottomItemContainer("Sell", 1, selectedItemColor),
        _bottomItemContainer("Inventory", 2, selectedItemColor),
        BottomNavigationBarItem(
            tooltip: '',
            icon: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: widget.currentIndex == 3
                        ? selectedItemColor
                        : Colors.white,
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(5, 20))),
                child: const Icon(
                  Icons.menu,
                  color: selectedItemTextColor,
                )),
            label: ""),
      ],
      currentIndex: widget.currentIndex,
      onTap: (index) => widget.onItemTapped(index),
    );
  }
}
