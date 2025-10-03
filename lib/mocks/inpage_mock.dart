import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/models/inpage_model.dart';

final purchaseOrderListProvider = StateProvider<List<GRPurchaseOrder>>(
  (ref) => [
    GRPurchaseOrder(
      id: 1,
      uniqueTitle: 'PO276IMP228250001',
      date: '4 Apr 2024, 02:15 PM',
      vendor: 'Agung Kurniawan',
    ),
    GRPurchaseOrder(
      id: 2,
      uniqueTitle: 'PO276IMP228250002',
      date: '5 Apr 2024, 09:30 AM',
      vendor: 'Siti Maimunah',
    ),
    GRPurchaseOrder(
      id: 3,
      uniqueTitle: 'PO276IMP228250003',
      date: '5 Apr 2024, 11:45 AM',
      vendor: 'Joko Santoso',
    ),
    GRPurchaseOrder(
      id: 4,
      uniqueTitle: 'PO276IMP228250004',
      date: '6 Apr 2024, 03:20 PM',
      vendor: 'Mbah Surip',
    ),
    GRPurchaseOrder(
      id: 5,
      uniqueTitle: 'PO276IMP228250005',
      date: '7 Apr 2024, 08:15 AM',
      vendor: 'Lasmini',
    ),
    GRPurchaseOrder(
      id: 6,
      uniqueTitle: 'PO276IMP228250006',
      date: '7 Apr 2024, 01:40 PM',
      vendor: 'Pak Dhe Karso',
    ),
    GRPurchaseOrder(
      id: 7,
      uniqueTitle: 'PO276IMP228250007',
      date: '8 Apr 2024, 10:10 AM',
      vendor: 'Mbak Sri Wahyuni',
    ),
    GRPurchaseOrder(
      id: 8,
      uniqueTitle: 'PO276IMP228250008',
      date: '8 Apr 2024, 04:30 PM',
      vendor: 'Mas Hendro',
    ),
    GRPurchaseOrder(
      id: 9,
      uniqueTitle: 'PO276IMP228250009',
      date: '9 Apr 2024, 09:55 AM',
      vendor: 'Bu Surti',
    ),
    GRPurchaseOrder(
      id: 10,
      uniqueTitle: 'PO276IMP228250010',
      date: '9 Apr 2024, 02:25 PM',
      vendor: 'Mbah Misri',
    ),
    GRPurchaseOrder(
      id: 11,
      uniqueTitle: 'PO276IMP228250011',
      date: '10 Apr 2024, 11:00 AM',
      vendor: 'Pak Lik Jono',
    ),
    GRPurchaseOrder(
      id: 12,
      uniqueTitle: 'PO276IMP228250012',
      date: '10 Apr 2024, 03:45 PM',
      vendor: 'Mbak Rina',
    ),
    GRPurchaseOrder(
      id: 13,
      uniqueTitle: 'PO276IMP228250013',
      date: '11 Apr 2024, 08:50 AM',
      vendor: 'Mas Bambang',
    ),
    GRPurchaseOrder(
      id: 14,
      uniqueTitle: 'PO276IMP228250014',
      date: '11 Apr 2024, 01:15 PM',
      vendor: 'Bu Parti',
    ),
    GRPurchaseOrder(
      id: 15,
      uniqueTitle: 'PO276IMP228250015',
      date: '12 Apr 2024, 10:30 AM',
      vendor: 'Mbah Karto',
    ),
    GRPurchaseOrder(
      id: 16,
      uniqueTitle: 'PO276IMP228250016',
      date: '12 Apr 2024, 04:05 PM',
      vendor: 'Pak De Marno',
    ),
    GRPurchaseOrder(
      id: 17,
      uniqueTitle: 'PO276IMP228250017',
      date: '13 Apr 2024, 09:20 AM',
      vendor: 'Mbak Yuli',
    ),
    GRPurchaseOrder(
      id: 18,
      uniqueTitle: 'PO276IMP228250018',
      date: '13 Apr 2024, 02:50 PM',
      vendor: 'Mas Heru',
    ),
    GRPurchaseOrder(
      id: 19,
      uniqueTitle: 'PO276IMP228250019',
      date: '14 Apr 2024, 11:35 AM',
      vendor: 'Bu Samsiah',
    ),
    GRPurchaseOrder(
      id: 20,
      uniqueTitle: 'PO276IMP228250020',
      date: '14 Apr 2024, 05:10 PM',
      vendor: 'Mbah Suroto',
    ),
  ],
);
