import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/services/rent_service.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';

class RentProvider extends ChangeNotifier {
  int amount = 1;
  Timestamp firstDate = Timestamp.now();
  Timestamp lastDate =
      Timestamp.fromDate(DateTime.now().add(const Duration(days: 1)));
  bool isRentUploading = false;

  void incraseAmount() {
    amount++;
    notifyListeners();
  }

  void decraseAmount() {
    amount--;
    notifyListeners();
  }

  Future<void> pickFirstDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: firstDate.toDate(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 150)),
    );

    if (pickedDate == null) {
      return;
    }

    if (pickedDate.day > lastDate.toDate().day &&
            pickedDate.month > lastDate.toDate().month &&
            pickedDate.year > lastDate.toDate().year ||
        pickedDate.day == lastDate.toDate().day) {
      firstDate = Timestamp.now();
      if (!context.mounted) return;
      customSnackBar(context, 'gagal mengganti tanggal');
      return;
    }

    firstDate = Timestamp.fromDate(pickedDate);
    notifyListeners();
  }

  Future<void> pickLastDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: lastDate.toDate(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 150)),
    );

    if (pickedDate == null) {
      return;
    }

    if (pickedDate.day < firstDate.toDate().day &&
            pickedDate.month < firstDate.toDate().month &&
            pickedDate.year < firstDate.toDate().year ||
        pickedDate.day == firstDate.toDate().day) {
      firstDate = Timestamp.now();
      if (!context.mounted) return;
      customSnackBar(context, 'gagal mengganti tanggal');
      return;
    }

    lastDate = Timestamp.fromDate(pickedDate);
    notifyListeners();
  }

  Future<void> rentStuff(BuildContext context, Post post) async {
    try {
      isRentUploading = true;
      notifyListeners();

      final totalPrice = amount *
          post.price *
          (lastDate.toDate().day - firstDate.toDate().day);

      if (auth.currentUser!.phoneNumber == null) {
        customSnackBar(context, 'tambahkan no hp terlebih dahulu');
        return;
      }

      // todo : ganti userPhoneNumber dan userName
      // final userPhoneNumber = auth.currentUser!.phoneNumber ?? '039393480212';
      // final userName = auth.currentUser!.displayName ?? 'anonymous';

      await RentService.createOrder(
        post.postId!,
        auth.currentUser!.uid,
        'anonymous',
        '039393480212',
        totalPrice,
        firstDate,
        lastDate,
        amount,
        false,
      );

      if (!context.mounted) return;
      context.pushNamed(AppRoute.paymentSucces);
    } catch (e) {
      customSnackBar(context, 'Gagal menyewa barang');
    }

    isRentUploading = false;
    notifyListeners();
  }
}
