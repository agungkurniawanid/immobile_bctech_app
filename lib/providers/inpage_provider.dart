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

final searchQueryProviderInpageDetail = StateProvider<String>((ref) => '');
final isSearchingProviderInpageDetail = StateProvider<bool>((ref) => false);

final filteredPurchaseOrderProviderDetail =
    Provider<List<GRPurchaseOrderDetail>>((ref) {
      final searchQuery = ref.watch(searchQueryProviderInpageDetail);
      final purchaseOrderListDetail = ref.watch(
        purchaseOrderListProviderDetail,
      );

      if (searchQuery.isEmpty) {
        return purchaseOrderListDetail;
      }

      return purchaseOrderListDetail.where((item) {
        return item.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            item.sku.contains(searchQuery) ||
            item.qty.toString().contains(searchQuery.toLowerCase());
      }).toList();
    });
