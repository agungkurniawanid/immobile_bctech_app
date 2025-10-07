import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/helpers/search_helper.dart';
import 'package:immobile_bctech_app/mocks/stock_take_mock.dart';
import 'package:immobile_bctech_app/models/stock_take_model.dart';

final currentTabIndexStockTakeProvider = StateProvider<int>((ref) => 0);

final filteredStockTakeProvider = createFilteredProvider<StockTakeModel>(
  key: 'stocktake',
  listProvider: stockTakeListProvider,
  filterFn: (item, query) => item.uniqueID.toLowerCase().contains(query),
);

final filteredStockTakeProviderDetail =
    createFilteredProvider<StockTakeModelDetail>(
      key: 'stocktakeDetail',
      listProvider: stockTakeListProviderDetail,
      filterFn: (item, query) =>
          item.uniqueID.toLowerCase().contains(query) ||
          item.uniqueIDStockTakeModelRef.toLowerCase().contains(query) ||
          item.createdBy.toLowerCase().contains(query),
    );

final filteredStockTakeProviderDetailInprogressOrCompleted =
    createFilteredProvider<StockTakeModelDetailInprogressOrCompleted>(
      key: 'stocktakeDetailInprogressOrCompleted',
      listProvider: stockTakeDetailList,
      filterFn: (item, query) =>
          item.headingTitle.toLowerCase().contains(query) ||
          item.kodeBox.toLowerCase().contains(query) ||
          item.sku.toLowerCase().contains(query) ||
          item.tagName.any((tag) => tag.toLowerCase().contains(query)) ||
          item.status.toLowerCase().contains(query),
    );
