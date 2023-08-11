import 'package:flutter/material.dart';

class Wallet {
  final String name;
  final double amount;
  final double percent;
  final double lineValue;
  final Color lineColor;

  Wallet({
    required this.name,
    required this.amount,
    required this.percent,
    required this.lineValue,
    required this.lineColor,
  });
}
