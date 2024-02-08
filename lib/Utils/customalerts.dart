import 'package:flutter/material.dart';

/// Custom Alert class to show alert dialogs across the app.

class CustomAlert extends StatelessWidget {
  
  final String title;
  final String description;
  final String leftButton;
  final String rightButton;
  final Function() completionCallback;

  const CustomAlert(
      {super.key,
      this.leftButton = 'Cancel',
      this.rightButton = 'OK',
      required this.description,
      required this.title,
      required this.completionCallback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(leftButton),
        ),
        TextButton(
          onPressed: () => completionCallback(),
          child: Text(rightButton),
        ),
      ],
    );
  }
}