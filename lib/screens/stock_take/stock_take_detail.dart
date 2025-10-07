import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobile_bctech_app/const/color_const.dart';
import 'package:immobile_bctech_app/helpers/search_helper.dart';
import 'package:immobile_bctech_app/models/stock_take_model.dart';
import 'package:immobile_bctech_app/providers/stock_take_provider.dart';
import 'package:immobile_bctech_app/screens/stock_take/stock_take_detail_inprogress_or_completed.dart';

class StockTakeDetail extends ConsumerStatefulWidget {
  final String uniqueIDStockTakeRef;
  const StockTakeDetail({super.key, required this.uniqueIDStockTakeRef});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StockTakeDetailState();
}

class _StockTakeDetailState extends ConsumerState<StockTakeDetail>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late TabController _tabController;

  static const String searchKey = 'stocktakeDetail';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      ref.read(currentTabIndexStockTakeProvider.notifier).state =
          _tabController.index;
    }
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = ref.watch(primaryColorProvider);
    final isSearching = ref.watch(isSearchingProviderFamily(searchKey));
    final searchQuery = ref.watch(searchQueryProviderFamily(searchKey));
    final filteredHistory = ref.watch(filteredStockTakeProviderDetail);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isSearching
          ? _buildSearchAppBar(primaryColor, searchQuery)
          : _buildNormalAppBar(primaryColor),
      body: Stack(
        children: [
          _buildBody(filteredHistory, isSearching, searchQuery, primaryColor),
          _buildFloatButton(),
        ],
      ),
    );
  }

  AppBar _buildNormalAppBar(Color primaryColor) {
    return AppBar(
      title: Text(
        '[${widget.uniqueIDStockTakeRef}]',
        style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          color: primaryColor,
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(text: 'In Progress'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
      ),
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
    List<StockTakeModelDetail> grPurchaseOrders,
    bool isSearching,
    String searchQuery,
    Color primaryColor,
  ) {
    if (isSearching && searchQuery.isEmpty) {
      return _buildSearchSuggestions();
    }

    if (isSearching && searchQuery.isNotEmpty && grPurchaseOrders.isEmpty) {
      return _buildNoResults(searchQuery);
    }

    // Jika sedang search, tampilkan hasil search tanpa tab bar
    if (isSearching) {
      return _buildSearchResults(grPurchaseOrders);
    }

    // Jika tidak search, tampilkan dengan tab bar
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Tab In Progress
              _buildInProgressTab(grPurchaseOrders),
              // Tab Completed
              _buildCompletedTab(grPurchaseOrders),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInProgressTab(List<StockTakeModelDetail> items) {
    // Filter items yang in progress (contoh: berdasarkan status atau kondisi tertentu)
    final inProgressItems = items.where((item) => item.id % 2 == 0).toList();

    if (inProgressItems.isEmpty) {
      return _buildEmptyTabState(
        icon: Icons.hourglass_empty,
        title: 'No in progress items',
        message: 'Your in progress items will appear here',
      );
    }

    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: inProgressItems.length,
            itemBuilder: (context, index) {
              final item = inProgressItems[index];
              return _buildHistoryItem(item, isCompleted: false);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedTab(List<StockTakeModelDetail> items) {
    // Filter items yang completed (contoh: berdasarkan status atau kondisi tertentu)
    final completedItems = items.where((item) => item.id % 2 == 1).toList();

    if (completedItems.isEmpty) {
      return _buildEmptyTabState(
        icon: Icons.check_circle_outline,
        title: 'No completed items',
        message: 'Your completed items will appear here',
      );
    }

    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: completedItems.length,
            itemBuilder: (context, index) {
              final item = completedItems[index];
              return _buildHistoryItem(item, isCompleted: true);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyTabState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<StockTakeModelDetail> items) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildHistoryItem(item, isCompleted: item.id % 2 == 1);
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

  Widget _buildHistoryItem(
    StockTakeModelDetail item, {
    bool isCompleted = false,
  }) {
    final primaryColor = ref.read(primaryColorProvider);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StockTakeDetailInprogressOrCompleted(
              createdBy: 'Agung Kurniawan',
              uniqueID: item.uniqueID,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isCompleted ? Color(0xFFF0F8FF) : Color(0xFFF7FBF2),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.green.shade200, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Color(0xFFB7E1B9)
                          : Color(0xFFB7F1B9),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        if (isCompleted)
                          Icon(
                            Icons.check_circle,
                            color: Colors.green.shade800,
                            size: 16,
                          ),
                        if (isCompleted) const SizedBox(width: 8),
                        Text(
                          item.uniqueID,
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Created By: ',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          item.createdBy,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Created At: ',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          item.createdAt,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isCompleted)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'COMPLETED',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FontAwesomeIcons.chevronRight,
                size: 16,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatButton() {
    final primaryColor = ref.watch(primaryColorProvider);
    final secondaryColor = ref.watch(secondaryColorProvider);

    final isSearching = ref.watch(isSearchingProviderFamily(searchKey));
    if (isSearching) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: 20,
      right: 20, // Pindah ke kanan
      child: Container(
        width: 60, // Tetap 60 untuk bentuk bulat
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, secondaryColor],
          ),
          shape: BoxShape.circle, // Ganti menjadi circle
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withValues(alpha: 0.4),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          shape: CircleBorder(), // Material shape circle
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {},
            child: const Icon(Icons.add, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }
}
