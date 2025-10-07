class StockTakeModel {
  final int id;
  final String uniqueID;
  StockTakeModel({required this.id, required this.uniqueID});
}

class StockTakeModelDetail {
  final int id;
  final String uniqueIDStockTakeModelRef;
  final String uniqueID;
  final String createdBy;
  final String createdAt;

  StockTakeModelDetail({
    required this.id,
    required this.uniqueIDStockTakeModelRef,
    required this.uniqueID,
    required this.createdBy,
    required this.createdAt,
  });
}

class StockTakeTableRowModel {
  final String label;
  final double unit;
  final double bun;
  final double box;
  final double kg;

  StockTakeTableRowModel({
    required this.label,
    required this.unit,
    required this.bun,
    required this.box,
    required this.kg,
  });
}

class StockTakeModelDetailInprogressOrCompleted {
  final int id;
  final String headingTitle;
  final String kodeBox;
  final String sku;
  final List<String> tagName;
  final String status;
  final List<StockTakeTableRowModel> tableData;
  final String uniqueID;

  StockTakeModelDetailInprogressOrCompleted({
    required this.id,
    required this.headingTitle,
    required this.kodeBox,
    required this.sku,
    required this.tagName,
    required this.status,
    required this.tableData,
    required this.uniqueID,
  });
}
