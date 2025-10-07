import 'package:immobile_bctech_app/helpers/search_base_provider.dart';
import 'package:immobile_bctech_app/mocks/outpage_mock.dart';
import 'package:immobile_bctech_app/models/outpage_model.dart';

final filteredSalesOrderProvider = createFilteredProvider<SalesOrder>(
  key: 'outpage',
  listProvider: salesOrderListProvider,
  filterFn: (item, query) =>
      item.uniqueTitle.toLowerCase().contains(query) ||
      item.date.contains(query) ||
      item.customer.toLowerCase().contains(query),
);

final filteredSalesOrderProviderDetail =
    createFilteredProvider<SalesOrderDetail>(
      key: 'outpageDetail',
      listProvider: salesOrderListProviderDetail,
      filterFn: (item, query) =>
          item.title.toLowerCase().contains(query) ||
          item.sku.contains(query) ||
          item.qty.toString().toLowerCase().contains(query),
    );
