import 'package:flutter/material.dart';

class GreyBar extends StatelessWidget {
  final String message;
  GreyBar(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      height: 75,
      color: Colors.grey,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Theme.of(context).hintColor),
          ),
        ),
      ),
    );
  }
}
