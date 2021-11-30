import 'package:flutter/material.dart';

void showMessageDialogue(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      });
}

String generateErrorMessage(Map<String, dynamic> badRequest) {
  if (badRequest['status'] == 'process failed') {
    Map<String, dynamic> err = badRequest['err'] as Map<String, dynamic>;
    switch (err['name']) {
      case 'UserExistsError':
        return err['message'] as String;
      default:
        return 'Unknown server error';
    }
  }
  switch (badRequest['status']) {
    case 'storeName already exists':
      return 'store name already exists';
    default:
      return badRequest['status'] as String;
  }
}
