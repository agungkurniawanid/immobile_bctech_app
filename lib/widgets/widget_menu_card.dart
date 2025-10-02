import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetMenuCard extends ConsumerStatefulWidget {
  final IconData? icon;
  final String? title;
  final Color? color;
  final Widget? page;
  const WidgetMenuCard({
    super.key,
    this.icon,
    this.title,
    this.color,
    this.page,
  });

  @override
  ConsumerState<WidgetMenuCard> createState() => _WidgetMenuCardState();
}

class _WidgetMenuCardState extends ConsumerState<WidgetMenuCard> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        onTap: () {
          if (widget.page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.page!),
            );
          }
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFECECEC),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      widget.icon ?? Icons.dashboard,
                      color: widget.color ?? Colors.black,
                      size: 34,
                    ),
                  ),
                ),
              ),
              // Container untuk title - 50% height
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.title ?? 'Menu',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
