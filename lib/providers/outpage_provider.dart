import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/mocks/outpage_mock.dart';
import 'package:immobile_bctech_app/models/outpage_model.dart';

final searchQueryProviderOutPage = StateProvider<String>((ref) => '');
final isSearchingProviderOutPage = StateProvider<bool>((ref) => false);
final searchQueryProviderOutPageDetail = StateProvider<String>((ref) => '');
final isSearchingProviderOutPageDetail = StateProvider<bool>((ref) => false);

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

final filteredSalesOrderProviderDetail = Provider<List<SalesOrderDetail>>((
  ref,
) {
  final searchQuery = ref.watch(searchQueryProviderOutPageDetail);
  final salesOrderList = ref.watch(salesOrderListProviderDetail);

  if (searchQuery.isEmpty) {
    return salesOrderList;
  }

  return salesOrderList.where((item) {
    return item.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
        item.sku.contains(searchQuery) ||
        item.qty.toString().toLowerCase().contains(searchQuery.toLowerCase());
  }).toList();
});
