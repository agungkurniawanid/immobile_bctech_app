import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:immobile_bctech_app/const/color_const.dart';
import 'package:immobile_bctech_app/helpers/search_helper.dart';
import 'package:immobile_bctech_app/mocks/inpage_mock.dart';
import 'package:immobile_bctech_app/models/outpage_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobile_bctech_app/providers/outpage_provider.dart';
import 'package:immobile_bctech_app/functions/dialog_function.dart';

class OutpageDetailScreen extends ConsumerStatefulWidget {
  const OutpageDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OutpageDetailScreenState();
}

class _OutpageDetailScreenState extends ConsumerState<OutpageDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  final TextEditingController _dateControllerTextField =
      TextEditingController();
  final TextEditingController _deliveredQuantityController =
      TextEditingController();
  final TextEditingController _customerController = TextEditingController();

  static const String searchKey = 'outpageDetail';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _dateControllerTextField.text = '20 Nov 2025';
    _deliveredQuantityController.text = '0';
    _customerController.text = 'Agung Kurniawan';
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
    _dateControllerTextField.dispose();
    _deliveredQuantityController.dispose();
    _customerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = ref.watch(primaryColorProvider);
    final isSearching = ref.watch(isSearchingProviderFamily(searchKey));
    final searchQuery = ref.watch(searchQueryProviderFamily(searchKey));
    final filteredHistory = ref.watch(filteredSalesOrderProviderDetail);

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
        'SO2762282500001',
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
    List<SalesOrderDetail> grPurchaseOrders,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _dateControllerTextField,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Sales Order Date',
                    labelStyle: const TextStyle(color: Color(0xFF7C7C7C)),
                    floatingLabelStyle: const TextStyle(
                      color: Color(0xFF024110),
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFD5D8DE),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF024110),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _deliveredQuantityController,
                  decoration: InputDecoration(
                    labelText: 'Delivered Quantity',
                    labelStyle: const TextStyle(color: Color(0xFF7C7C7C)),
                    floatingLabelStyle: const TextStyle(
                      color: Color(0xFF024110),
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFD5D8DE),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF024110),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: TextField(
            controller: _customerController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Customer',
              labelStyle: const TextStyle(color: Color(0xFF7C7C7C)),
              floatingLabelStyle: const TextStyle(
                color: Color(0xFF024110),
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFD5D8DE),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF024110),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Expanded dengan ListView - DIPERBAIKI
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: grPurchaseOrders.length,
                  padding: const EdgeInsets.only(bottom: 100),
                  itemBuilder: (context, index) {
                    final item = grPurchaseOrders[index];
                    return _buildHistoryItem(item);
                  },
                ),
                _buildFloatButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatButton() {
    final primaryColor = ref.watch(primaryColorProvider);
    final secondaryColor = ref.watch(secondaryColorProvider);

    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryColor, secondaryColor],
            ),
            borderRadius: BorderRadius.circular(30),
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
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                showSaveWarningPopup(
                  context,
                  "Are you sure to save sales order document?",
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Save Sales Order',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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

  Widget _buildHistoryItem(SalesOrderDetail item) {
    return InkWell(
      onTap: () {
        _showItemDetailBottomSheet(item);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SKU: ${item.sku}',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Qty: ${item.qty.toString()}',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          item.qty.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'PCS',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 16,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDetailBottomSheet(SalesOrderDetail item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Item Details',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close, size: 24),
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: Colors.grey.shade300),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: DottedBorder(
                              options: RoundedRectDottedBorderOptions(
                                dashPattern: [10, 5],
                                radius: Radius.circular(12),
                                strokeWidth: 2,
                                padding: EdgeInsets.all(16),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.image,
                                      size: 32,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      'No Image Available',
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'SKU: ${item.sku}',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF7FBF2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildDetailRow('SKU', item.sku),
                            SizedBox(height: 12),
                            _buildQuantityRow(item),
                            SizedBox(height: 12),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Expanded(
                              child: TextField(
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Serial Number',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF7C7C7C),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFD5D8DE),
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFD5D8DE),
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF024110),
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical:
                                        22, // biar teks sejajar secara vertikal
                                  ),
                                ),
                                cursorColor: Colors.black,
                              ),
                            ),

                            // Button
                            Positioned(
                              right: 0,
                              child: SizedBox(
                                width: 100,
                                height: 60,
                                child: Material(
                                  color: const Color(0xFF024110),
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add_rounded,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Add',
                                            style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '6 / 6 Serial Number Filled',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Column(
                        children: List.generate(serialNumbers.length, (index) {
                          final serial = serialNumbers[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Color(0xFFD5D8DE),
                                  width: 1,
                                ),
                              ),
                              elevation: 0,
                              color: Colors.white,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.green.shade100,
                                  child: Text(
                                    '${index + 1}',
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade900,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  serial,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      serialNumbers.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Close',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF024110),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Save',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityRow(SalesOrderDetail item) {
    final TextEditingController qtyController = TextEditingController(
      text: item.qty.toString(),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Delivered Quantity',
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (item.qty > 0) {
                    setState(() {
                      item.qty--;
                      qtyController.text = item.qty.toString();
                    });
                  }
                },
                icon: Icon(
                  Icons.remove,
                  size: 24,
                  color: item.qty > 0
                      ? Colors.red.shade600
                      : Colors.grey.shade400,
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                constraints: BoxConstraints(minWidth: 32, minHeight: 32),
              ),

              Container(
                width: 70,
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: TextField(
                  controller: qtyController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    hintText: '0',
                    suffixText: 'PCS',
                    suffixStyle: GoogleFonts.roboto(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      int newQty = int.tryParse(value) ?? 0;
                      setState(() {
                        item.qty = newQty;
                      });
                    }
                  },
                  onSubmitted: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        item.qty = 0;
                        qtyController.text = '0';
                      });
                    }
                  },
                ),
              ),

              IconButton(
                onPressed: () {
                  setState(() {
                    item.qty++;
                    qtyController.text = item.qty.toString();
                  });
                },
                icon: Icon(Icons.add, size: 24, color: Colors.green.shade600),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                constraints: BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
