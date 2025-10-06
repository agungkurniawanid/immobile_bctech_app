import 'package:flutter/material.dart';
import 'package:immobile_bctech_app/widgets/save_warning_popup_widget.dart';

void showSaveWarningPopup(BuildContext context, [String? warningText]) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) =>
        SaveWarningPopupWidget(onSave: () {}, warningText: warningText),
  );
}
