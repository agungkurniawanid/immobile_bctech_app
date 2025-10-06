import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/mocks/history_mock.dart';
import 'package:immobile_bctech_app/mocks/inpage_mock.dart';
import 'package:immobile_bctech_app/mocks/outpage_mock.dart';
import 'package:immobile_bctech_app/models/history_model.dart';
import 'package:immobile_bctech_app/models/inpage_model.dart';
import 'package:immobile_bctech_app/models/outpage_model.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final isSearchingProvider = StateProvider<bool>((ref) => false);

final searchQueryProviderHistoryInpageDetail = StateProvider<String>(
  (ref) => '',
);
final isSearchingProviderHistoryInpageDetail = StateProvider<bool>(
  (ref) => false,
);

final searchQueryProviderHistoryOutPageDetail = StateProvider<String>(
  (ref) => '',
);
final isSearchingProviderHistoryOutPageDetail = StateProvider<bool>(
  (ref) => false,
);

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

final filteredHistoryPurchaseOrderProviderDetail =
    Provider<List<GRPurchaseOrderDetail>>((ref) {
      final searchQuery = ref.watch(searchQueryProviderHistoryInpageDetail);
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

final filteredHistorySalesOrderProviderDetail =
    Provider<List<SalesOrderDetail>>((ref) {
      final searchQuery = ref.watch(searchQueryProviderHistoryOutPageDetail);
      final salesOrderList = ref.watch(salesOrderListProviderDetail);

      if (searchQuery.isEmpty) {
        return salesOrderList;
      }

      return salesOrderList.where((item) {
        return item.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            item.sku.contains(searchQuery) ||
            item.qty.toString().toLowerCase().contains(
              searchQuery.toLowerCase(),
            );
      }).toList();
    });
