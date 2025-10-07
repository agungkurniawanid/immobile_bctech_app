import 'package:immobile_bctech_app/helpers/search_base_provider.dart';
import 'package:immobile_bctech_app/mocks/inpage_mock.dart';
import 'package:immobile_bctech_app/models/inpage_model.dart';

final filteredPurchaseOrderProvider = createFilteredProvider<GRPurchaseOrder>(
  key: 'inpage',
  listProvider: purchaseOrderListProvider,
  filterFn: (item, query) =>
      item.uniqueTitle.toLowerCase().contains(query) ||
      item.date.contains(query) ||
      item.vendor.toLowerCase().contains(query),
);

final filteredPurchaseOrderProviderDetail =
    createFilteredProvider<GRPurchaseOrderDetail>(
      key: 'inpageDetail',
      listProvider: purchaseOrderListProviderDetail,
      filterFn: (item, query) =>
          item.title.toLowerCase().contains(query) ||
          item.sku.contains(query) ||
          item.qty.toString().contains(query),
    );
