import 'package:ds_market_place/domain/failure.dart';
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    Key? key,
    required this.failure,
    required this.onRetry,
    this.color,
  }) : super(key: key);

  final Failure failure;
  final VoidCallback onRetry;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(failure.message),
        SizedBox(height: 15),
        ElevatedButton(
          onPressed: onRetry,
          child: Text('RETRY'),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        )
      ],
    );
  }
}
