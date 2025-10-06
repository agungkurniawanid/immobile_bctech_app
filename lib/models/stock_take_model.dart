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
