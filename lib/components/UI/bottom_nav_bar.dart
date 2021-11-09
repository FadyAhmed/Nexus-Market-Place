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
      Widget title, int index, var selectedItemColor) {
    return BottomNavigationBarItem(
      tooltip: '',
      icon: FittedBox(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: widget.currentIndex == index
                    ? selectedItemColor
                    : Colors.transparent,
                borderRadius:
                    const BorderRadius.all(Radius.elliptical(20, 20))),
            child: title),
      ),
      label: "",
    );
  }

  @override
  Widget build(BuildContext context) {
    var selectedItemColor = Theme.of(context).primaryColor;
    return BottomNavigationBar(
      elevation: 5,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        _bottomItemContainer(
            Text(
              "Explore",
              style: _textStyle(widget.currentIndex),
            ),
            0,
            selectedItemColor),
        _bottomItemContainer(
            Text(
              "Store",
              style: _textStyle(widget.currentIndex),
            ),
            1,
            selectedItemColor),
        _bottomItemContainer(
            Text(
              "Inventory",
              style: _textStyle(widget.currentIndex),
            ),
            2,
            selectedItemColor),
        _bottomItemContainer(
            const Icon(
              Icons.menu,
              color: selectedItemTextColor,
            ),
            3,
            selectedItemColor),
      ],
      currentIndex: widget.currentIndex,
      onTap: (index) => widget.onItemTapped(index),
    );
  }
}
