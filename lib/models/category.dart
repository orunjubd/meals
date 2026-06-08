import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  //final String color;
  final Color color;

  const Category({
    required this.id,
    required this.title,
    //this.color = '#FFA500',
    //this.colorDef = const Color.fromRGBO(255, 165, 0, 1),
    this.color = Colors.orange,
  });
}
