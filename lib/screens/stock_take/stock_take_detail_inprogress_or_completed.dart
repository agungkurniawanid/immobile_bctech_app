import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobile_bctech_app/const/color_const.dart';
import 'package:immobile_bctech_app/helpers/search_helper.dart';
import 'package:immobile_bctech_app/models/stock_take_model.dart';
import 'package:immobile_bctech_app/providers/stock_take_provider.dart';

class StockTakeDetailInprogressOrCompleted extends ConsumerStatefulWidget {
  final String? createdBy;
  final String? uniqueID;
  const StockTakeDetailInprogressOrCompleted({
    super.key,
    this.createdBy,
    this.uniqueID,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StockTakeDetailInprogressOrCompletedState();
}

class _StockTakeDetailInprogressOrCompletedState
    extends ConsumerState<StockTakeDetailInprogressOrCompleted> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  static const String searchKey = 'stocktakeDetailInprogressOrCompleted';

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
    final filteredHistory = ref.watch(
      filteredStockTakeProviderDetailInprogressOrCompleted,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: isSearching
          ? _buildSearchAppBar(primaryColor, searchQuery)
          : _buildNormalAppBar(primaryColor),
      body: _buildBody(filteredHistory, isSearching, searchQuery),
    );
  }

  AppBar _buildNormalAppBar(Color primaryColor) {
    return AppBar(
      title: Text(
        widget.uniqueID ?? 'Stock ID',
        style: GoogleFonts.roboto(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: false,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      actions: [
        IconButton(
          icon: Icon(FontAwesomeIcons.book, size: 24),
          onPressed: () {},
          tooltip: 'Noted',
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.qrcode, size: 24),
          onPressed: () {},
          tooltip: 'QR Code',
        ),
        IconButton(
          icon: const Icon(Icons.search, size: 26),
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
      elevation: 2,
      automaticallyImplyLeading: false,
      title: _buildSearchField(primaryColor),
      actions: [
        if (searchQuery.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear, size: 22),
            onPressed: _clearSearch,
            tooltip: 'Clear search',
          ),
        IconButton(
          icon: const Icon(Icons.close, size: 24),
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
                hintText: 'Search Stock Take...',
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
    List<StockTakeModelDetailInprogressOrCompleted> stockTakeList,
    bool isSearching,
    String searchQuery,
  ) {
    if (isSearching && searchQuery.isEmpty) {
      return _buildSearchSuggestions();
    }

    if (isSearching && searchQuery.isNotEmpty && stockTakeList.isEmpty) {
      return _buildNoResults(searchQuery);
    }

    if (stockTakeList.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${stockTakeList.length} of ${stockTakeList.length} Data Shown",
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
              ),
              Text(
                widget.createdBy ?? 'Agung Kurniawan',
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildSummaryCards(stockTakeList),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: stockTakeList.length,
            itemBuilder: (context, index) {
              final item = stockTakeList[index];
              return _buildModernCard(item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(
    List<StockTakeModelDetailInprogressOrCompleted> stockTakeList,
  ) {
    final completedCount = stockTakeList
        .where((item) => item.status == 'completed')
        .length;
    final inProgressCount = stockTakeList
        .where((item) => item.status == 'inprogress')
        .length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              'Completed',
              completedCount.toString(),
              Colors.green,
              Icons.check_circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildSummaryCard(
              'In Progress',
              inProgressCount.toString(),
              Colors.orange,
              Icons.autorenew,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const Spacer(),
              Text(
                value,
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernCard(StockTakeModelDetailInprogressOrCompleted item) {
    final primaryColor = ref.watch(primaryColorProvider);
    final isCompleted = item.status == 'completed';

    // State untuk menandai apakah card sedang dipilih/checked
    final isSelectedProvider = StateProvider.family<bool, String>(
      (ref, uniqueId) => false,
    );
    final isSelected = ref.watch(isSelectedProvider(item.uniqueID));

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ref.read(isSelectedProvider(item.uniqueID).notifier).state =
                !isSelected;
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isCompleted ? Colors.green : Colors.orange,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isCompleted ? Icons.check_circle : Icons.autorenew,
                            size: 14,
                            color: isCompleted ? Colors.green : Colors.orange,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isCompleted ? 'Completed' : 'In Progress',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isCompleted ? Colors.green : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Toggle antara status circle dan checkbox
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: isSelected
                          ? // Checkbox ketika dipilih
                            Container(
                              key: const ValueKey('checkbox'),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              ),
                            )
                          : // Status circle ketika tidak dipilih
                            Container(
                              key: const ValueKey('circle'),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? Colors.green
                                    : Colors.orange,
                                shape: BoxShape.circle,
                              ),
                            ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Informasi utama
                Text(
                  item.headingTitle,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 12),

                // Informasi detail
                _buildInfoRow('Box Code', item.kodeBox),
                _buildInfoRow('SKU', item.sku),

                const SizedBox(height: 12),

                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: item.tagName.map((tag) => _buildTag(tag)).toList(),
                ),

                const SizedBox(height: 16),

                // Summary table
                _buildTableSummary(item.tableData),

                const SizedBox(height: 8),

                // Footer dengan arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'View Details',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Text(
        tag,
        style: GoogleFonts.roboto(
          fontSize: 12,
          color: Colors.blue.shade700,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTableSummary(List<StockTakeTableRowModel> tableData) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Header tabel dengan label UNIT yang sejajar
          _buildTableHeader(),
          const SizedBox(height: 8),
          // Garis pemisah
          Container(height: 1, color: Colors.grey.shade300),
          const SizedBox(height: 8),
          // Data rows
          ...tableData.map((row) => _buildTableRow(row)),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'UNIT', // Label UNIT yang sejajar dengan kolom
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Bun',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Box',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'KG',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(StockTakeTableRowModel row) {
    final isDifferent = row.label == 'Different';
    final hasNegativeValue = row.bun < 0 || row.box < 0 || row.kg < 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              row.label, // Stock, Physical, Different
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDifferent
                    ? (hasNegativeValue ? Colors.red : Colors.green)
                    : Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.bun.toStringAsFixed(1), // Data BUN
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDifferent
                    ? (row.bun < 0 ? Colors.red : Colors.green)
                    : Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.box.toStringAsFixed(1), // Data BOX
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDifferent
                    ? (row.box < 0 ? Colors.red : Colors.green)
                    : Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.kg.toStringAsFixed(1), // Data KG
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDifferent
                    ? (row.kg < 0 ? Colors.red : Colors.green)
                    : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    final suggestions = [
      'Completed',
      'In Progress',
      'Head 10 Kg',
      'Ceker Bersih',
      '11100001',
      '11110003',
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
    final primaryColor = ref.watch(primaryColorProvider);

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
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No Stock Take Data',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your stock take records will appear here',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
