class SalesOrder {
  int id;
  String uniqueTitle;
  String date;
  String customer;
  SalesOrder({
    required this.id,
    required this.uniqueTitle,
    required this.date,
    required this.customer,
  });
}

class SalesOrderDetail {
  int id;
  String title;
  String sku;
  int qty;
  SalesOrderDetail({
    required this.id,
    required this.title,
    required this.sku,
    required this.qty,
  });
}
