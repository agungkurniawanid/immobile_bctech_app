import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:immobile_bctech_app/models/stock_take_model.dart';

final stockTakeListProvider = StateProvider<List<StockTakeModel>>((ref) {
  final uniqueIds = [
    '1721-BD20',
    '1872-RC50',
    '1900-AB33',
    '1721-BD21',
    '2001-XZ88',
    '3000-KL11',
    '1872-RC77',
    '1800-BB10',
    '1750-ZZ99',
    '1999-DD12',
    '1822-BN34',
    '1872-RC81',
    '1555-AA01',
    '2100-CC55',
    '1777-DD77',
    '1650-MM20',
    '1888-RR90',
    '1901-KK45',
    '1400-BB22',
    '1788-NN78',
  ];

  return List.generate(uniqueIds.length, (index) {
    return StockTakeModel(id: index + 1, uniqueID: uniqueIds[index]);
  });
});

final stockTakeListProviderDetail = StateProvider<List<StockTakeModelDetail>>((
  ref,
) {
  final stockTakeList = ref.watch(stockTakeListProvider);
  final createdByList = [
    'Agung Kurniawan',
    'Dewi Lestari',
    'Budi Santoso',
    'Rina Putri',
    'Andi Wijaya',
    'Siti Nurhaliza',
    'Dimas Pratama',
    'Intan Ayu',
    'Teguh Saputra',
    'Nina Kartika',
    'Rizky Ramadhan',
    'Citra Dewi',
    'Wahyu Hidayat',
    'Lia Agustina',
    'Anton Susilo',
    'Putri Aisyah',
    'Gilang Mahendra',
    'Yuni Rahayu',
    'Eko Purnomo',
    'Farah Anjani',
  ];

  final createdAtList = [
    '01 Jan 2025',
    '03 Jan 2025',
    '05 Jan 2025',
    '07 Jan 2025',
    '10 Jan 2025',
    '12 Jan 2025',
    '14 Jan 2025',
    '15 Jan 2025',
    '17 Jan 2025',
    '20 Jan 2025',
    '22 Jan 2025',
    '25 Jan 2025',
    '26 Jan 2025',
    '28 Jan 2025',
    '29 Jan 2025',
    '30 Jan 2025',
    '02 Feb 2025',
    '05 Feb 2025',
    '08 Feb 2025',
    '10 Feb 2025',
  ];

  return List.generate(stockTakeList.length, (index) {
    final item = stockTakeList[index];

    return StockTakeModelDetail(
      id: item.id,
      uniqueIDStockTakeModelRef: item.uniqueID,
      uniqueID: 'PID${item.uniqueID}${item.id}',
      createdBy: createdByList[index],
      createdAt: createdAtList[index],
    );
  });
});

final stockTakeDetailList =
    Provider<List<StockTakeModelDetailInprogressOrCompleted>>((ref) {
      return [
        StockTakeModelDetailInprogressOrCompleted(
          id: 1,
          headingTitle: 'Head 10 Kg',
          kodeBox: '11100001',
          sku: '11100001',
          tagName: ['UU', 'QI', 'BLOCK'],
          status: 'completed',
          uniqueID: 'ST001',
          tableData: [
            StockTakeTableRowModel(
              label: 'Stock',
              unit: 120.0,
              bun: 12.0,
              box: 120.0,
              kg: 120.0,
            ),
            StockTakeTableRowModel(
              label: 'Physical',
              unit: 0.0,
              bun: 0.0,
              box: 0.0,
              kg: 0.0,
            ),
            StockTakeTableRowModel(
              label: 'Different',
              unit: -120.0,
              bun: 0.0,
              box: 0.0,
              kg: 0.0,
            ),
          ],
        ),
        StockTakeModelDetailInprogressOrCompleted(
          id: 2,
          headingTitle: 'Ceker Bersih',
          kodeBox: '11110003',
          sku: '11110003',
          tagName: ['UU', 'QI', 'BLOCK'],
          status: 'inprogress',
          uniqueID: 'ST002',
          tableData: [
            StockTakeTableRowModel(
              label: 'Stock',
              unit: 47.0,
              bun: 7.8,
              box: 47.0,
              kg: 47.0,
            ),
            StockTakeTableRowModel(
              label: 'Physical',
              unit: 0.0,
              bun: 0.0,
              box: 0.0,
              kg: 0.0,
            ),
            StockTakeTableRowModel(
              label: 'Different',
              unit: -47.9,
              bun: 0.0,
              box: 0.0,
              kg: 0.0,
            ),
          ],
        ),
      ];
    });
