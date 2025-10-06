import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/mocks/stock_take_mock.dart';
import 'package:immobile_bctech_app/models/stock_take_model.dart';

final searchQueryProviderStockTake = StateProvider<String>((ref) => '');
final isSearchingProviderStockTake = StateProvider<bool>((ref) => false);

final searchQueryProviderStockTakeDetail = StateProvider<String>((ref) => '');
final isSearchingProviderStockTakeDetail = StateProvider<bool>((ref) => false);

final searchQueryProviderStockTakeDetailInprogressOrCompleted =
    StateProvider<String>((ref) => '');
final isSearchingProviderStockTakeDetailInprogressOrCompleted =
    StateProvider<bool>((ref) => false);

final currentTabIndexStockTakeProvider = StateProvider<int>((ref) => 0);

final filteredStockTakeProvider = Provider<List<StockTakeModel>>((ref) {
  final searchQuery = ref.watch(searchQueryProviderStockTake);
  final stockTakeOrderList = ref.watch(stockTakeListProvider);

  if (searchQuery.isEmpty) {
    return stockTakeOrderList;
  }

  return stockTakeOrderList.where((item) {
    return item.uniqueID.toLowerCase().contains(searchQuery.toLowerCase());
  }).toList();
});

final filteredStockTakeProviderDetail = Provider<List<StockTakeModelDetail>>((
  ref,
) {
  final searchQuery = ref.watch(searchQueryProviderStockTakeDetail);
  final stockTakeOrderList = ref.watch(stockTakeListProviderDetail);

  if (searchQuery.isEmpty) {
    return stockTakeOrderList;
  }

  return stockTakeOrderList.where((item) {
    return item.uniqueID.toLowerCase().contains(searchQuery.toLowerCase()) ||
        item.uniqueIDStockTakeModelRef.toLowerCase().contains(
          searchQuery.toLowerCase(),
        ) ||
        item.createdBy.toLowerCase().contains(searchQuery.toLowerCase());
  }).toList();
});

// Provider untuk filtered data
final filteredStockTakeProviderDetailInprogressOrCompleted =
    Provider<List<StockTakeModelDetailInprogressOrCompleted>>((ref) {
      final searchQuery = ref.watch(
        searchQueryProviderStockTakeDetailInprogressOrCompleted,
      );
      final stockTakeOrderList = ref.watch(stockTakeDetailList);

      if (searchQuery.isEmpty) {
        return stockTakeOrderList;
      }

      final lowerQuery = searchQuery.toLowerCase();

      return stockTakeOrderList.where((item) {
        return item.headingTitle.toLowerCase().contains(lowerQuery) ||
            item.kodeBox.toLowerCase().contains(lowerQuery) ||
            item.sku.toLowerCase().contains(lowerQuery) ||
            item.tagName.any((tag) => tag.toLowerCase().contains(lowerQuery)) ||
            item.status.toLowerCase().contains(lowerQuery);
      }).toList();
    });
