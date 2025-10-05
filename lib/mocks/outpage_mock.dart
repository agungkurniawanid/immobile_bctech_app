// outpage_mock.dart
import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/models/outpage_model.dart';

final salesOrderListProvider = StateProvider<List<SalesOrder>>(
  (ref) => [
    SalesOrder(
      id: 1,
      uniqueTitle: 'SO276EXP228250001',
      date: '6 Apr 2024, 09:10 AM',
      customer: 'Rizky Ananda',
    ),
    SalesOrder(
      id: 2,
      uniqueTitle: 'SO276EXP228250002',
      date: '6 Apr 2024, 04:25 PM',
      customer: 'Dewi Lestari',
    ),
    SalesOrder(
      id: 3,
      uniqueTitle: 'SO276EXP228250003',
      date: '7 Apr 2024, 10:00 AM',
      customer: 'Bagus Saputra',
    ),
    SalesOrder(
      id: 4,
      uniqueTitle: 'SO276EXP228250004',
      date: '7 Apr 2024, 02:40 PM',
      customer: 'Wulan Sari',
    ),
    SalesOrder(
      id: 5,
      uniqueTitle: 'SO276EXP228250005',
      date: '8 Apr 2024, 09:30 AM',
      customer: 'Adi Putra',
    ),
    SalesOrder(
      id: 6,
      uniqueTitle: 'SO276EXP228250006',
      date: '8 Apr 2024, 03:10 PM',
      customer: 'Rina Oktaviani',
    ),
    SalesOrder(
      id: 7,
      uniqueTitle: 'SO276EXP228250007',
      date: '9 Apr 2024, 10:45 AM',
      customer: 'Hendri Gunawan',
    ),
    SalesOrder(
      id: 8,
      uniqueTitle: 'SO276EXP228250008',
      date: '9 Apr 2024, 05:00 PM',
      customer: 'Dimas Prasetyo',
    ),
    SalesOrder(
      id: 9,
      uniqueTitle: 'SO276EXP228250009',
      date: '10 Apr 2024, 08:50 AM',
      customer: 'Citra Ayu',
    ),
    SalesOrder(
      id: 10,
      uniqueTitle: 'SO276EXP228250010',
      date: '10 Apr 2024, 03:35 PM',
      customer: 'Reza Maulana',
    ),
    SalesOrder(
      id: 11,
      uniqueTitle: 'SO276EXP228250011',
      date: '11 Apr 2024, 09:10 AM',
      customer: 'Teguh Firmansyah',
    ),
    SalesOrder(
      id: 12,
      uniqueTitle: 'SO276EXP228250012',
      date: '11 Apr 2024, 01:55 PM',
      customer: 'Desi Rahmawati',
    ),
    SalesOrder(
      id: 13,
      uniqueTitle: 'SO276EXP228250013',
      date: '12 Apr 2024, 10:05 AM',
      customer: 'Yudha Prabowo',
    ),
    SalesOrder(
      id: 14,
      uniqueTitle: 'SO276EXP228250014',
      date: '12 Apr 2024, 04:20 PM',
      customer: 'Lina Marlina',
    ),
    SalesOrder(
      id: 15,
      uniqueTitle: 'SO276EXP228250015',
      date: '13 Apr 2024, 09:45 AM',
      customer: 'Gilang Permana',
    ),
    SalesOrder(
      id: 16,
      uniqueTitle: 'SO276EXP228250016',
      date: '13 Apr 2024, 02:15 PM',
      customer: 'Maya Anggraini',
    ),
    SalesOrder(
      id: 17,
      uniqueTitle: 'SO276EXP228250017',
      date: '14 Apr 2024, 11:10 AM',
      customer: 'Rizal Hidayat',
    ),
    SalesOrder(
      id: 18,
      uniqueTitle: 'SO276EXP228250018',
      date: '14 Apr 2024, 05:40 PM',
      customer: 'Anita Sulastri',
    ),
    SalesOrder(
      id: 19,
      uniqueTitle: 'SO276EXP228250019',
      date: '15 Apr 2024, 08:55 AM',
      customer: 'Naufal Fadillah',
    ),
    SalesOrder(
      id: 20,
      uniqueTitle: 'SO276EXP228250020',
      date: '15 Apr 2024, 03:25 PM',
      customer: 'Bella Kartika',
    ),
  ],
);

final salesOrderListProviderDetail = StateProvider<List<SalesOrderDetail>>(
  (ref) => [
    SalesOrderDetail(
      id: 1,
      title: 'DJI MAVIC 3 ENTERPRISE DRONE BUNDLE',
      sku: '2050464',
      qty: 3,
    ),
    SalesOrderDetail(
      id: 2,
      title: 'DJI AIR 3 FLY MORE COMBO',
      sku: '2050465',
      qty: 4,
    ),
    SalesOrderDetail(
      id: 3,
      title: 'DJI MINI 4 PRO DRONE KIT',
      sku: '2050466',
      qty: 5,
    ),
    SalesOrderDetail(
      id: 4,
      title: 'AUTEL EVO LITE+ DRONE',
      sku: '2050467',
      qty: 2,
    ),
    SalesOrderDetail(
      id: 5,
      title: 'PARROT ANAFI AI DRONE 48MP',
      sku: '2050468',
      qty: 6,
    ),
    SalesOrderDetail(
      id: 6,
      title: 'DJI AVATA 2 FPV EXPLORER COMBO',
      sku: '2050469',
      qty: 4,
    ),
    SalesOrderDetail(
      id: 7,
      title: 'DJI INSPIRE 3 PRO DRONE PACKAGE',
      sku: '2050470',
      qty: 1,
    ),
    SalesOrderDetail(
      id: 8,
      title: 'YUNEEC H850 INDUSTRIAL DRONE',
      sku: '2050471',
      qty: 3,
    ),
    SalesOrderDetail(
      id: 9,
      title: 'DJI RONIN 4D CAMERA 6K COMBO',
      sku: '2050472',
      qty: 5,
    ),
    SalesOrderDetail(
      id: 10,
      title: 'DJI OSMO POCKET 3 CAMERA',
      sku: '2050473',
      qty: 7,
    ),
    SalesOrderDetail(
      id: 11,
      title: 'DJI ACTION 4 CAMERA ADVENTURE SET',
      sku: '2050474',
      qty: 9,
    ),
    SalesOrderDetail(
      id: 12,
      title: 'DJI MIC 2 DUAL CHANNEL WIRELESS',
      sku: '2050475',
      qty: 10,
    ),
    SalesOrderDetail(
      id: 13,
      title: 'DJI RS 4 PRO GIMBAL STABILIZER',
      sku: '2050476',
      qty: 2,
    ),
    SalesOrderDetail(
      id: 14,
      title: 'DJI MINI 3 FLY MORE COMBO',
      sku: '2050477',
      qty: 8,
    ),
    SalesOrderDetail(
      id: 15,
      title: 'DJI AIR 2S DRONE COMBO',
      sku: '2050478',
      qty: 6,
    ),
    SalesOrderDetail(
      id: 16,
      title: 'DJI MAVIC 2 ENTERPRISE ADVANCED',
      sku: '2050479',
      qty: 3,
    ),
    SalesOrderDetail(
      id: 17,
      title: 'DJI AGRAS T20 AGRICULTURE DRONE',
      sku: '2050480',
      qty: 5,
    ),
    SalesOrderDetail(
      id: 18,
      title: 'DJI FPV GOGGLES V2',
      sku: '2050481',
      qty: 7,
    ),
    SalesOrderDetail(
      id: 19,
      title: 'DJI OSMO MOBILE 6 SMARTPHONE GIMBAL',
      sku: '2050482',
      qty: 4,
    ),
    SalesOrderDetail(
      id: 20,
      title: 'DJI TRIPOD MOUNT KIT',
      sku: '2050483',
      qty: 11,
    ),
  ],
);

final List<String> serialNumbersOutPage = [
  '9876543210',
  '9876543211',
  '9876543212',
  '9876543213',
  '9876543214',
  '9876543215',
  '9876543216',
  '9876543217',
  '9876543218',
  '9876543219',
];
