import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:immobile_bctech_app/const/color_const.dart';

class WidgetStock extends ConsumerStatefulWidget {
  final String? id,
      date,
      totalItem,
      totalQty,
      titlePODate,
      titleTotalItem,
      titleTotalQty;
  const WidgetStock({
    super.key,
    this.id,
    this.date,
    this.totalItem,
    this.totalQty,
    this.titlePODate,
    this.titleTotalItem,
    this.titleTotalQty,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WidgetStockState();
}

class _WidgetStockState extends ConsumerState<WidgetStock> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = ref.watch(primaryColorProvider);
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFF7FBF2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Text(
              widget.id ?? "PO276IMP228250004",
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                _buildInfoRow(
                  widget.titlePODate ?? "PO Date:",
                  widget.date ?? "20 Nov 2025",
                ),
                const SizedBox(height: 6),
                _buildInfoRow(
                  widget.titleTotalItem ?? "Total Item:",
                  widget.totalItem ?? "4",
                ),
                const SizedBox(height: 6),
                _buildInfoRow(
                  widget.titleTotalQty ?? "Total Qty:",
                  widget.totalQty ?? "20",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
