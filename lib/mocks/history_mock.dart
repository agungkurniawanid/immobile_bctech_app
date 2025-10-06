import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/models/history_model.dart';
import 'package:immobile_bctech_app/screens/history/history_inpage_screen.dart';
import 'package:immobile_bctech_app/screens/history/history_outpage_screen.dart';

final historyListProvider = StateProvider<List<HistoryModel>>(
  (ref) => [
    HistoryModel(
      id: 1,
      title: 'PO276IMP228250004',
      date: '4 Apr 2024, 02:15 PM',
      amount: 'Agung Kurniawan',
      label: 'Good Receive',
      page: HistoryInpageScreen(),
    ),
    HistoryModel(
      id: 2,
      title: 'GI276IMP228250003',
      date: '20 Nov 2025, 10:30 AM',
      amount: 'Budi Santoso',
      label: 'Good Issue',
      page: HistoryOutpageScreen(),
    ),
    HistoryModel(
      id: 3,
      title: 'SO276IMP228250002',
      date: '15 Aug 2024, 09:45 AM',
      amount: 'Icha Riska',
      label: 'Sales Order',
      page: HistoryOutpageScreen(),
    ),
    HistoryModel(
      id: 4,
      title: 'SR276IMP228250001',
      date: '10 Jan 2024, 11:00 AM',
      amount: 'Dewi Lestari',
      label: 'Sales Return',
      page: HistoryInpageScreen(),
    ),
  ],
);
