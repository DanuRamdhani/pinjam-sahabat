import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/src/home/services/rent_service.dart';
import 'package:pinjam_sahabat/src/profile/providers/profile_provider.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
import 'package:pinjam_sahabat/utils/format.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final profileProv = context.read<ProfileProvider>();
    final getPostProv = context.read<GetPostProvider>();

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

      final phoneNumber = profileProv.userData!['phoneNumber'];
      final userName = profileProv.userData!['username'];

      String message =
          'Halo, saya $userName ingin meminjam barang dari Anda. Berikut adalah detailnya:\n\n';
      message += '- Nama Peminjam: $userName\n';
      message += '- Nama Barang: ${post.title}\n';
      message += '- Jumlah Barang: $amount\n';
      message += '- Deskripsi: ${post.desc}\n';
      message += '- Tanggal Mulai Peminjaman: ${dateFormatted(firstDate)}\n';
      message += '- Tanggal Pengembalian: ${dateFormatted(lastDate)}\n';
      message += '- Harga/hari: ${priceFormated(post.price, false)}\n';
      message += '- Total harga: ${priceFormated(totalPrice, false)}\n\n';
      message += 'Terima kasih.';

      await RentService.createOrder(
        post.postId!,
        auth.currentUser!.uid,
        userName,
        phoneNumber,
        totalPrice,
        firstDate,
        lastDate,
        amount,
        false,
      );

      if (!context.mounted) return;
      context.pushNamed(AppRoute.paymentSucces);
      Future.delayed(
        const Duration(seconds: 2),
        () async {
          await sendWhatsAppMessage(context, phoneNumber, message);
        },
      );
      getPostProv.refreshPost(context);
    } catch (e) {
      if (!context.mounted) return;
      customSnackBar(context, 'Gagal menyewa barang : $e');
    }

    isRentUploading = false;
    notifyListeners();
  }

  Future<void> sendWhatsAppMessage(
    BuildContext context,
    String phoneNumber,
    String message,
  ) async {
    final formatPhoneNumber = convertToInternationalFormat(phoneNumber);

    String encodedMessage = Uri.encodeFull(message);

    String url = "https://wa.me/$formatPhoneNumber/?text=$encodedMessage";

    await launchUrl(Uri.parse(url));
  }

  String convertToInternationalFormat(String phoneNumber) {
    phoneNumber = phoneNumber.replaceAll(RegExp('^0+'), '');

    if (!phoneNumber.startsWith('+')) {
      phoneNumber = '+62$phoneNumber';
    }

    return phoneNumber;
  }
}
