import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/main_wrapper/providers/main_wrapper_provider.dart';
import 'package:pinjam_sahabat/src/user_post/services/user_post_service.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class AddPostProvider extends ChangeNotifier {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController rulesCtrl = TextEditingController();

  File? pickedImage;
  List<String> selectedCategory = [];
  List<String> rules = [];
  bool isUploading = false;

  double? lat;
  double? lon;

  Future<void> uploadPost(BuildContext context) async {
    final mainWrapperProv = context.read<MainWrapperProvider>();
    final getPostProv = context.read<GetPostProvider>();

    try {
      isUploading = true;
      notifyListeners();

      if (lat == null || lon == null) {
        customSnackBar(context, 'Pilih lokasi anda');
        isUploading = false;
        notifyListeners();
        return;
      } else if (titleCtrl.text.trim().isEmpty ||
          descCtrl.text.isEmpty ||
          pickedImage == null) {
        customSnackBar(context, 'Isi semua form');
        isUploading = false;
        notifyListeners();
        return;
      } else if (selectedCategory.isEmpty) {
        customSnackBar(context, 'Tambahkan minimal 1 kategori');
        isUploading = false;
        notifyListeners();
        return;
      }

      if (priceCtrl.text.trim().isEmpty) {
        priceCtrl.text = '0';
      }

      if (amountCtrl.text.trim().isEmpty || amountCtrl.text.trim() == '0') {
        amountCtrl.text = '1';
      }

      final priceParse = int.parse(priceCtrl.text);
      final amountParse = int.parse(amountCtrl.text);

      await UserPostService.createPost(
        context,
        pickedImage!,
        titleCtrl.text,
        descCtrl.text,
        priceParse,
        lat!,
        lon!,
        amountParse,
        selectedCategory,
        rules,
      );

      isUploading = false;
      notifyListeners();
      if (!context.mounted) return;
      Navigator.of(context).popUntil(
        (route) => route.settings.name == AppRoute.mainWrapper,
      );
      mainWrapperProv.onItemTapped(context, 0);
      await getPostProv.refreshPost(context);

      titleCtrl.clear();
      descCtrl.clear();
      priceCtrl.clear();
      amountCtrl.clear();
      selectedCategory.clear();
      rules.clear();
      pickedImage = null;
      lat = null;
      lon = null;

      if (!context.mounted) return;
      customSnackBar(context, 'Tambah barang berhasil');
    } catch (e) {
      isUploading = false;
      notifyListeners();
      customSnackBar(context, 'Tambah barang gagal');
    }
  }

  Future<void> takeImageGallery(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    pickedImage = File(image.path);
    notifyListeners();
    if (!context.mounted) return;
    context.pop();
  }

  Future<void> takeImageCamera(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    pickedImage = File(image.path);
    notifyListeners();
    if (!context.mounted) return;
    context.pop();
  }

  void deleteSelectedCategory(value) {
    selectedCategory.remove(value);
    notifyListeners();
  }

  void addLocation(BuildContext context) {
    final locProv = context.read<LocationProvider>();
    lat = locProv.initialLoc.latitude;
    lon = locProv.initialLoc.longitude;
    notifyListeners();
  }
}
