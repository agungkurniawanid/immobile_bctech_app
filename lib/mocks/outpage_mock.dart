import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/models/outpage_model.dart';

final salesOrderListProvider = StateProvider<List<SalesOrder>>(
  (ref) => [
    SalesOrder(
      id: 1,
      uniqueTitle: 'PO276IMP228250001',
      date: '4 Apr 2024, 02:15 PM',
      customer: 'Agung Kurniawan',
    ),
    SalesOrder(
      id: 2,
      uniqueTitle: 'PO276IMP228250002',
      date: '5 Apr 2024, 09:30 AM',
      customer: 'Siti Maimunah',
    ),
    SalesOrder(
      id: 3,
      uniqueTitle: 'PO276IMP228250003',
      date: '5 Apr 2024, 11:45 AM',
      customer: 'Joko Santoso',
    ),
    SalesOrder(
      id: 4,
      uniqueTitle: 'PO276IMP228250004',
      date: '6 Apr 2024, 03:20 PM',
      customer: 'Mbah Surip',
    ),
    SalesOrder(
      id: 5,
      uniqueTitle: 'PO276IMP228250005',
      date: '7 Apr 2024, 08:15 AM',
      customer: 'Lasmini',
    ),
    SalesOrder(
      id: 6,
      uniqueTitle: 'PO276IMP228250006',
      date: '7 Apr 2024, 01:40 PM',
      customer: 'Pak Dhe Karso',
    ),
    SalesOrder(
      id: 7,
      uniqueTitle: 'PO276IMP228250007',
      date: '8 Apr 2024, 10:10 AM',
      customer: 'Mbak Sri Wahyuni',
    ),
    SalesOrder(
      id: 8,
      uniqueTitle: 'PO276IMP228250008',
      date: '8 Apr 2024, 04:30 PM',
      customer: 'Mas Hendro',
    ),
    SalesOrder(
      id: 9,
      uniqueTitle: 'PO276IMP228250009',
      date: '9 Apr 2024, 09:55 AM',
      customer: 'Bu Surti',
    ),
    SalesOrder(
      id: 10,
      uniqueTitle: 'PO276IMP228250010',
      date: '9 Apr 2024, 02:25 PM',
      customer: 'Mbah Misri',
    ),
    SalesOrder(
      id: 11,
      uniqueTitle: 'PO276IMP228250011',
      date: '10 Apr 2024, 11:00 AM',
      customer: 'Pak Lik Jono',
    ),
    SalesOrder(
      id: 12,
      uniqueTitle: 'PO276IMP228250012',
      date: '10 Apr 2024, 03:45 PM',
      customer: 'Mbak Rina',
    ),
    SalesOrder(
      id: 13,
      uniqueTitle: 'PO276IMP228250013',
      date: '11 Apr 2024, 08:50 AM',
      customer: 'Mas Bambang',
    ),
    SalesOrder(
      id: 14,
      uniqueTitle: 'PO276IMP228250014',
      date: '11 Apr 2024, 01:15 PM',
      customer: 'Bu Parti',
    ),
    SalesOrder(
      id: 15,
      uniqueTitle: 'PO276IMP228250015',
      date: '12 Apr 2024, 10:30 AM',
      customer: 'Mbah Karto',
    ),
    SalesOrder(
      id: 16,
      uniqueTitle: 'PO276IMP228250016',
      date: '12 Apr 2024, 04:05 PM',
      customer: 'Pak De Marno',
    ),
    SalesOrder(
      id: 17,
      uniqueTitle: 'PO276IMP228250017',
      date: '13 Apr 2024, 09:20 AM',
      customer: 'Mbak Yuli',
    ),
    SalesOrder(
      id: 18,
      uniqueTitle: 'PO276IMP228250018',
      date: '13 Apr 2024, 02:50 PM',
      customer: 'Mas Heru',
    ),
    SalesOrder(
      id: 19,
      uniqueTitle: 'PO276IMP228250019',
      date: '14 Apr 2024, 11:35 AM',
      customer: 'Bu Samsiah',
    ),
    SalesOrder(
      id: 20,
      uniqueTitle: 'PO276IMP228250020',
      date: '14 Apr 2024, 05:10 PM',
      customer: 'Mbah Suroto',
    ),
  ],
);
