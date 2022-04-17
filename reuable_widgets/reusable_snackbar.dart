import 'package:flutter/material.dart';

void reusableSnackBar(
    {required BuildContext context,
    required String contentText,
    Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 1000),
    content: Text(
      contentText,
    ),
    backgroundColor: color ?? Theme.of(context).primaryColor,
  ));
}
