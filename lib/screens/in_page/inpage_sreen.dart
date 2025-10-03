import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:immobile_bctech_app/const/color_const.dart';
import 'package:immobile_bctech_app/models/inpage_model.dart';
import 'package:immobile_bctech_app/providers/inpage_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:immobile_bctech_app/screens/in_page/inpage_detail_screen.dart';

class InpageSreen extends ConsumerStatefulWidget {
  const InpageSreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InpageSreenState();
}

class _InpageSreenState extends ConsumerState<InpageSreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    ref.read(searchQueryProviderInpage.notifier).state = _searchController.text;
  }

  void _startSearch() {
    ref.read(isSearchingProviderInpage.notifier).state = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  void _stopSearch() {
    ref.read(isSearchingProviderInpage.notifier).state = false;
    ref.read(searchQueryProviderInpage.notifier).state = '';
    _searchController.clear();
    _searchFocusNode.unfocus();
  }

  void _clearSearch() {
    ref.read(searchQueryProviderInpage.notifier).state = '';
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
    final isSearching = ref.watch(isSearchingProviderInpage);
    final searchQuery = ref.watch(searchQueryProviderInpage);
    final filteredHistory = ref.watch(filteredPurchaseOrderProvider);

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
        'GR In Purchase Order',
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
    List<GRPurchaseOrder> grPurchaseOrders,
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

    final primaryColor = ref.watch(primaryColorProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${grPurchaseOrders.length} of ${grPurchaseOrders.length} Data Shown",
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF7FBF2),
                  border: Border.all(color: primaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  value: 'PO Date',
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: const Icon(
                      FontAwesomeIcons.arrowDownWideShort,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(12),
                  elevation: 2,
                  dropdownColor: Colors.white,
                  style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                  items: ['PO Date', 'SO Date'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: grPurchaseOrders.length,
            itemBuilder: (context, index) {
              final item = grPurchaseOrders[index];
              return _buildHistoryItem(item);
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

  Widget _buildHistoryItem(GRPurchaseOrder item) {
    final primaryColor = ref.read(primaryColorProvider);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return InpageDetailSreen();
            },
          ),
        );
      },
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFB7F1B9),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    item.uniqueTitle,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'PO Date: ${item.date}',
                  style: GoogleFonts.roboto(fontSize: 14, color: Colors.black),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Vendor: ',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    item.vendor,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
