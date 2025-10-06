import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/mocks/stock_take_mock.dart';
import 'package:immobile_bctech_app/models/stock_take_model.dart';

final searchQueryProviderStockTake = StateProvider<String>((ref) => '');
final isSearchingProviderStockTake = StateProvider<bool>((ref) => false);

final currentTabIndexStockTakeProvider = StateProvider<int>((ref) => 0);

final searchQueryProviderStockTakeDetail = StateProvider<String>((ref) => '');
final isSearchingProviderStockTakeDetail = StateProvider<bool>((ref) => false);

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
