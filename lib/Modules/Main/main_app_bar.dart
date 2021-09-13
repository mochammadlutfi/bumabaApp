import 'package:flutter/material.dart';

AppBar mainappbar(String title) {
  return AppBar(
    leading: BackButton(
      color: Colors.white
    ),
    elevation: 0,
    titleSpacing: 0,
    title: Text(title, style: TextStyle(color: Colors.white,)),
  );
}
