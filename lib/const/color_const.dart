import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final primaryColorProvider = Provider<Color>((ref) => const Color(0xFF00880C));

final primarySoftColorProvider = Provider<Color>(
  (ref) => const Color(0xFFE0FBD2),
);

final secondaryColorProvider = Provider<Color>(
  (ref) => const Color(0xFF4CAF50),
);
