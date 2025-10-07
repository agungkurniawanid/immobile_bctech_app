import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobile_bctech_app/const/color_const.dart';
import 'package:immobile_bctech_app/helpers/search_helper.dart';
import 'package:immobile_bctech_app/models/stock_take_model.dart';
import 'package:immobile_bctech_app/providers/stock_take_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:immobile_bctech_app/screens/stock_take/stock_take_detail.dart';

class StockTakeScreen extends ConsumerStatefulWidget {
  const StockTakeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StockTakeScreenState();
}

class _StockTakeScreenState extends ConsumerState<StockTakeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  static const String searchKey = 'stocktake';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    ref.read(searchQueryProviderFamily(searchKey).notifier).state =
        _searchController.text;
  }

  void _startSearch() {
    ref.read(isSearchingProviderFamily(searchKey).notifier).state = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  void _stopSearch() {
    ref.read(isSearchingProviderFamily(searchKey).notifier).state = false;
    ref.read(searchQueryProviderFamily(searchKey).notifier).state = '';
    _searchController.clear();
    _searchFocusNode.unfocus();
  }

  void _clearSearch() {
    ref.read(searchQueryProviderFamily(searchKey).notifier).state = '';
    _searchController.clear();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = ref.watch(primaryColorProvider);
    final isSearching = ref.watch(isSearchingProviderFamily(searchKey));
    final searchQuery = ref.watch(searchQueryProviderFamily(searchKey));
    final filteredHistory = ref.watch(filteredStockTakeProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isSearching
          ? _buildSearchAppBar(primaryColor, searchQuery)
          : _buildNormalAppBar(primaryColor),
      body: _buildBody(filteredHistory, isSearching, searchQuery),
    );
  }

  AppBar _buildNormalAppBar(Color primaryColor) {
    return AppBar(
      title: Text(
        'Stock Take',
        style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _startSearch,
          tooltip: 'Search',
        ),
      ],
    );
  }

  PreferredSizeWidget _buildSearchAppBar(
    Color primaryColor,
    String searchQuery,
  ) {
    return AppBar(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: _buildSearchField(primaryColor),
      actions: [
        if (searchQuery.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearSearch,
            tooltip: 'Clear search',
          ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: _stopSearch,
          tooltip: 'Close search',
        ),
      ],
      toolbarHeight: 80,
    );
  }

  Widget _buildSearchField(Color primaryColor) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                hintText: 'Search Purchase Order...',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 18,
                ),
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: Icon(
                    Icons.search,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 24,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                isDense: false,
              ),
              cursorColor: Colors.white,
              autofocus: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    List<StockTakeModel> grPurchaseOrders,
    bool isSearching,
    String searchQuery,
  ) {
    if (isSearching && searchQuery.isEmpty) {
      return _buildSearchSuggestions();
    }

    if (isSearching && searchQuery.isNotEmpty && grPurchaseOrders.isEmpty) {
      return _buildNoResults(searchQuery);
    }

    if (grPurchaseOrders.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: grPurchaseOrders.length,
            itemBuilder: (context, index) {
              final item = grPurchaseOrders[index];
              return _buildHistoryItem(
                item,
                StockTakeDetail(uniqueIDStockTakeRef: item.uniqueID),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSuggestions() {
    final suggestions = [
      'Today',
      'This week',
      'Payment',
      'Refund',
      'Transaction',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Recent Searches',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.history,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                ),
                title: Text(
                  suggestions[index],
                  style: const TextStyle(fontSize: 16),
                ),
                onTap: () {
                  _searchController.text = suggestions[index];
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNoResults(String query) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'No matches for "$query"',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _clearSearch,
              style: FilledButton.styleFrom(
                backgroundColor: ref.read(primaryColorProvider),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('Clear Search'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No history yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your transaction history will appear here',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(StockTakeModel item, [Widget? route]) {
    final primaryColor = ref.read(primaryColorProvider);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Color(0xFFF7FBF2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route!),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(34.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '[${item.uniqueID}]',
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Last Transaction',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.chevronRight,
                    size: 16,
                    color: primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
