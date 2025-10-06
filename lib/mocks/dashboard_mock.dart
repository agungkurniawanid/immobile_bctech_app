import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:immobile_bctech_app/screens/in_page/inpage_sreen.dart';
import 'package:immobile_bctech_app/screens/out_page/outpage_screen.dart';
import 'package:immobile_bctech_app/screens/stock_take/stock_take_screen.dart';

final List<Map<String, dynamic>> menuItems = [
  {
    'icon': FontAwesomeIcons.box,
    'title': 'In',
    'color': Colors.red,
    'page': InpageSreen(),
  },
  {
    'icon': FontAwesomeIcons.arrowRightFromBracket,
    'title': 'Out',
    'color': const Color(0xFF024110),
    'page': OutpageScreen(),
  },
  {
    'icon': FontAwesomeIcons.truck,
    'title': 'Stock Take',
    'color': Colors.indigoAccent,
    'page': StockTakeScreen(),
  },
  {
    'icon': FontAwesomeIcons.ellipsis,
    'title': 'More',
    'color': Colors.purpleAccent,
    'page': null,
  },
];
