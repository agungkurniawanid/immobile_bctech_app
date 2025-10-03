import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final primaryColorProvider = Provider<Color>((ref) => const Color(0xFF024110));

final secondaryColorProvider = Provider<Color>(
  (ref) => const Color(0xFF237730),
);
