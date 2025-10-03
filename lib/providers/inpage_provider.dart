import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/mocks/inpage_mock.dart';
import 'package:immobile_bctech_app/models/inpage_model.dart';

final searchQueryProviderInpage = StateProvider<String>((ref) => '');
final isSearchingProviderInpage = StateProvider<bool>((ref) => false);

final filteredPurchaseOrderProvider = Provider<List<GRPurchaseOrder>>((ref) {
  final searchQuery = ref.watch(searchQueryProviderInpage);
  final purchaseOrderList = ref.watch(purchaseOrderListProvider);

  if (searchQuery.isEmpty) {
    return purchaseOrderList;
  }

  return purchaseOrderList.where((item) {
    return item.uniqueTitle.toLowerCase().contains(searchQuery.toLowerCase()) ||
        item.date.contains(searchQuery) ||
        item.vendor.toLowerCase().contains(searchQuery.toLowerCase());
  }).toList();
});
