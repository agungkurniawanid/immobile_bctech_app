import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/misc.dart';

final searchQueryProviderFamily = StateProvider.family<String, String>(
  (ref, key) => '',
);

final isSearchingProviderFamily = StateProvider.family<bool, String>(
  (ref, key) => false,
);

Provider<List<T>> createFilteredProvider<T>({
  required String key,
  required ProviderListenable<List<T>> listProvider,
  required bool Function(T item, String query) filterFn,
}) {
  return Provider<List<T>>((ref) {
    final searchQuery = ref.watch(searchQueryProviderFamily(key));
    final list = ref.watch(listProvider);

    if (searchQuery.isEmpty) {
      return list;
    }

    final lowerQuery = searchQuery.toLowerCase();
    return list.where((item) => filterFn(item, lowerQuery)).toList();
  });
}
