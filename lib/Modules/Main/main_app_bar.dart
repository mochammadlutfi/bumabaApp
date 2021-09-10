import 'package:flutter/material.dart';

AppBar mainappbar(String title) {
  return AppBar(
    leading: BackButton(
      color: Colors.white
    ), 
    titleSpacing: 0,
    title: Text(title, style: TextStyle(color: Colors.white,)),
  );
}
