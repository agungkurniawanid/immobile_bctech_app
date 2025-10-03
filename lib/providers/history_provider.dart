import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/mocks/history_mock.dart';
import 'package:immobile_bctech_app/models/history_model.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final isSearchingProvider = StateProvider<bool>((ref) => false);

final filteredHistoryProvider = Provider<List<HistoryModel>>((ref) {
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
