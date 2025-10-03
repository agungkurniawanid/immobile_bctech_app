import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/mocks/outpage_mock.dart';
import 'package:immobile_bctech_app/models/outpage_model.dart';

final searchQueryProviderOutPage = StateProvider<String>((ref) => '');
final isSearchingProviderOutPage = StateProvider<bool>((ref) => false);

final filteredSalesOrderProvider = Provider<List<SalesOrder>>((ref) {
  final searchQuery = ref.watch(searchQueryProviderOutPage);
  final salesOrderList = ref.watch(salesOrderListProvider);

  if (searchQuery.isEmpty) {
    return salesOrderList;
  }

  return salesOrderList.where((item) {
    return item.uniqueTitle.toLowerCase().contains(searchQuery.toLowerCase()) ||
        item.date.contains(searchQuery) ||
        item.customer.toLowerCase().contains(searchQuery.toLowerCase());
  }).toList();
});
