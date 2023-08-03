import 'package:flutter/material.dart';

Future<dynamic> openScreen(BuildContext context, Widget screen) {
  return Future.microtask(
    () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    ),
  );
}
