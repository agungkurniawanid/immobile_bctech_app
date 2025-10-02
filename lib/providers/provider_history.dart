import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Provider untuk search state
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider untuk search mode state
final isSearchingProvider = StateProvider<bool>((ref) => false);

// Provider untuk data history (contoh)
final historyListProvider = StateProvider<List<HistoryItem>>(
  (ref) => [
    HistoryItem(
      id: 1,
      title: 'PO276IMP228250004',
      date: '4 Apr 2024, 02:15 PM',
      amount: 'Agung Kurniawan',
      label: 'Good Receive',
    ),
    HistoryItem(
      id: 2,
      title: 'GI276IMP228250003',
      date: '20 Nov 2025, 10:30 AM',
      amount: 'Budi Santoso',
      label: 'Good Issue',
    ),
    HistoryItem(
      id: 3,
      title: 'SO276IMP228250002',
      date: '15 Aug 2024, 09:45 AM',
      amount: 'Icha Riska',
      label: 'Sales Order',
    ),
    HistoryItem(
      id: 4,
      title: 'SR276IMP228250001',
      date: '10 Jan 2024, 11:00 AM',
      amount: 'Dewi Lestari',
      label: 'Sales Return',
    ),
  ],
);

// Provider untuk filtered history (computed)
final filteredHistoryProvider = Provider<List<HistoryItem>>((ref) {
  final searchQuery = ref.watch(searchQueryProvider);
  final historyList = ref.watch(historyListProvider);

  if (searchQuery.isEmpty) {
    return historyList;
  }

  return historyList.where((item) {
    return item.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
        item.date.contains(searchQuery) ||
        item.amount.toLowerCase().contains(searchQuery.toLowerCase());
  }).toList();
});

// Model untuk history item
class HistoryItem {
  final int id;
  final String title;
  final String date;
  final String amount;
  final String label;

  HistoryItem({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.label,
  });
}
