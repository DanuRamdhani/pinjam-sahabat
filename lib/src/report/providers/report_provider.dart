import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/report/list_report.dart';
import 'package:pinjam_sahabat/src/report/services/report_service.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';

class ReportProvider extends ChangeNotifier {
  String? selectedOption;
  String otherDescription = '';
  bool isLoading = false;

  void onChanged(value) {
    otherDescription = value;
    notifyListeners();
  }

  void onChangedRadio(value) {
    selectedOption = value;
    otherDescription = '';
    notifyListeners();
  }

  Future<void> report(BuildContext context, String postId) async {
    isLoading = true;
    notifyListeners();
    try {
      String? message = selectedOption;

      if (selectedOption == null && otherDescription.trim().isEmpty) {
        customSnackBar(context, 'isi pesan report');
        return;
      }

      if (selectedOption == reportDescriptions.last) {
        message = otherDescription;
      }
      await ReportService.createReport(message!, postId);

      isLoading = false;
      notifyListeners();
      if (!context.mounted) return;
      customSnackBar(context, 'report berhasil');
      context.pop();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      customSnackBar(context, 'report gagal, coba lagi nanti');
    }
  }
}
