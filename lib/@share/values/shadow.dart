import 'package:flutter/material.dart';

List<BoxShadow> shadow1 = [
  BoxShadow(
    color: Colors.grey.shade100,
    spreadRadius: 0,
    blurRadius: 4,
    offset: const Offset(0, 2), // changes position of shadow
  )
];

List<BoxShadow> shadowTop = [
  BoxShadow(
      color: Colors.grey.shade200,
      blurRadius: 15.0,
      offset: const Offset(0.0, 0.75))
];

List<BoxShadow> shadow3 = [
  BoxShadow(
    color: Colors.grey.shade200,
    spreadRadius: 0,
    blurRadius: 12,
    offset: const Offset(0, 6), // changes position of shadow
  )
];

List<BoxShadow> shadow4 = [
  BoxShadow(
    color: Colors.grey.shade200,
    spreadRadius: 0,
    blurRadius: 16,
    offset: const Offset(0, 8), // changes position of shadow
  )
];
