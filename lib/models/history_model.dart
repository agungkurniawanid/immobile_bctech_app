import 'package:flutter/widgets.dart';

class HistoryModel {
  final int id;
  final String title;
  final String date;
  final String amount;
  final String label;
  final Widget page;

  HistoryModel({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.label,
    required this.page,
  });
}
