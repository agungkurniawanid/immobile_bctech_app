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

final purchaseOrderListProviderDetail =
    StateProvider<List<GRPurchaseOrderDetail>>(
      (ref) => [
        GRPurchaseOrderDetail(
          id: 1,
          title:
              'DJI 2600W 4 CHANNEL INTELLIGENT BATTERY DRONE PRO WITH 4K CAMERA',
          sku: '1050464',
          qty: 6,
        ),
        GRPurchaseOrderDetail(
          id: 2,
          title: 'DJI MAVIC AIR 2 FLY MORE COMBO WITH 4K CAMERA',
          sku: '1050465',
          qty: 3,
        ),
        GRPurchaseOrderDetail(
          id: 3,
          title: 'PARROT ANAFI DRONE 4K HDR CAMERA',
          sku: '1050466',
          qty: 5,
        ),
        GRPurchaseOrderDetail(
          id: 4,
          title: 'AUTEL EVO II PRO 6K DRONE',
          sku: '1050467',
          qty: 2,
        ),
        GRPurchaseOrderDetail(
          id: 5,
          title: 'DJI MINI 3 PRO DRONE WITH SMART CONTROLLER',
          sku: '1050468',
          qty: 7,
        ),
        GRPurchaseOrderDetail(
          id: 6,
          title: 'DJI FPV COMBO DRONE KIT',
          sku: '1050469',
          qty: 4,
        ),
        GRPurchaseOrderDetail(
          id: 7,
          title: 'DJI INSPIRE 2 PREMIUM COMBO WITH X5S CAMERA',
          sku: '1050470',
          qty: 1,
        ),
        GRPurchaseOrderDetail(
          id: 8,
          title: 'DJI PHANTOM 4 PRO V2.0',
          sku: '1050471',
          qty: 9,
        ),
        GRPurchaseOrderDetail(
          id: 9,
          title: 'YUNEEC TYPHOON H PRO DRONE WITH REALSENSE',
          sku: '1050472',
          qty: 6,
        ),
        GRPurchaseOrderDetail(
          id: 10,
          title: 'DJI MATRICE 300 RTK ENTERPRISE DRONE',
          sku: '1050473',
          qty: 2,
        ),
        GRPurchaseOrderDetail(
          id: 11,
          title: 'DJI AGRAS T40 AGRICULTURE DRONE',
          sku: '1050474',
          qty: 10,
        ),
        GRPurchaseOrderDetail(
          id: 12,
          title: 'DJI MAVIC 3 CLASSIC DRONE',
          sku: '1050475',
          qty: 8,
        ),
        GRPurchaseOrderDetail(
          id: 13,
          title: 'DJI AVATA EXPLORER COMBO DRONE',
          sku: '1050476',
          qty: 4,
        ),
        GRPurchaseOrderDetail(
          id: 14,
          title: 'DJI MINI 2 SE DRONE',
          sku: '1050477',
          qty: 12,
        ),
        GRPurchaseOrderDetail(
          id: 15,
          title: 'DJI AIR 3 DRONE WITH DUAL CAMERA',
          sku: '1050478',
          qty: 5,
        ),
        GRPurchaseOrderDetail(
          id: 16,
          title: 'DJI MAVIC 2 ZOOM DRONE',
          sku: '1050479',
          qty: 7,
        ),
        GRPurchaseOrderDetail(
          id: 17,
          title: 'DJI MAVIC 2 PRO DRONE',
          sku: '1050480',
          qty: 6,
        ),
        GRPurchaseOrderDetail(
          id: 18,
          title: 'DJI SPARK FLY MORE COMBO',
          sku: '1050481',
          qty: 11,
        ),
        GRPurchaseOrderDetail(
          id: 19,
          title: 'DJI RONIN-S HANDHELD GIMBAL',
          sku: '1050482',
          qty: 3,
        ),
        GRPurchaseOrderDetail(
          id: 20,
          title: 'DJI OSMO ACTION CAMERA 4K',
          sku: '1050483',
          qty: 9,
        ),
      ],
    );

final List<String> serialNumbers = [
  '1234567890',
  '1234567891',
  '1234567892',
  '1234567893',
  '1234567894',
  '1234567895',
  '1234567896',
  '1234567897',
  '1234567898',
  '1234567899',
];
