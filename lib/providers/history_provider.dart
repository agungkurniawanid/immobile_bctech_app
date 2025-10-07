import 'package:immobile_bctech_app/mocks/history_mock.dart';
import 'package:immobile_bctech_app/mocks/inpage_mock.dart';
import 'package:immobile_bctech_app/mocks/outpage_mock.dart';
import 'package:immobile_bctech_app/models/history_model.dart';
import 'package:immobile_bctech_app/models/inpage_model.dart';
import 'package:immobile_bctech_app/models/outpage_model.dart';
import 'package:immobile_bctech_app/helpers/search_helper.dart';

final filteredHistoryProvider = createFilteredProvider<HistoryModel>(
  key: 'history',
  listProvider: historyListProvider,
  filterFn: (item, query) =>
      item.title.toLowerCase().contains(query) ||
      item.date.contains(query) ||
      item.amount.toLowerCase().contains(query),
);

final filteredHistoryPurchaseOrderProviderDetail =
    createFilteredProvider<GRPurchaseOrderDetail>(
      key: 'historyInpageDetail',
      listProvider: purchaseOrderListProviderDetail,
      filterFn: (item, query) =>
          item.title.toLowerCase().contains(query) ||
          item.sku.contains(query) ||
          item.qty.toString().contains(query),
    );

final filteredHistorySalesOrderProviderDetail =
    createFilteredProvider<SalesOrderDetail>(
      key: 'historyOutPageDetail',
      listProvider: salesOrderListProviderDetail,
      filterFn: (item, query) =>
          item.title.toLowerCase().contains(query) ||
          item.sku.contains(query) ||
          item.qty.toString().toLowerCase().contains(query),
    );
