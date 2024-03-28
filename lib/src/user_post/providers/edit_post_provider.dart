import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_user_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/user_post/services/user_post_service.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class EditPostProvider extends ChangeNotifier {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController amountCtrl = TextEditingController();
  TextEditingController rulesCtrl = TextEditingController();

  File? pickedImage;
  List<String> selectedCategory = [];
  List<String> rules = [];
  bool isLoading = false;

  double? lat;
  double? lon;

  void initializePostData({
    required String title,
    required String price,
    required String amount,
    required String description,
    required List<String> categoriesFromPost,
    required double latPost,
    required double lonPost,
  }) {
    titleCtrl.text = title;
    descCtrl.text = description;
    priceCtrl.text = price;
    amountCtrl.text = amount;
    selectedCategory = categoriesFromPost;
    lat = latPost;
    lon = lonPost;
  }

  Future<void> updatePost(
    BuildContext context,
    String postId,
    num rating,
  ) async {
    final getPostProv = context.read<GetPostProvider>();
    final getUserPostProv = context.read<GetUserPostProvider>();

    try {
      isLoading = true;
      notifyListeners();

      if (lat == null || lon == null) {
        isLoading = false;
        notifyListeners();
        customSnackBar(context, 'Pilih lokasi anda');
        return;
      } else if (titleCtrl.text.trim().isEmpty ||
          descCtrl.text.isEmpty ||
          pickedImage == null) {
        isLoading = false;
        notifyListeners();
        customSnackBar(context, 'Isi semua form');
        return;
      } else if (selectedCategory.isEmpty) {
        isLoading = false;
        notifyListeners();
        customSnackBar(context, 'Tambahkan minimal 1 kategori');
        return;
      }

      if (priceCtrl.text.trim().isEmpty) {
        priceCtrl.text = '0';
      }

      if (amountCtrl.text.trim().isEmpty) {
        priceCtrl.text = '1';
      }

      final priceParse = int.parse(priceCtrl.text);
      final amountParse = int.parse(amountCtrl.text);

      await UserPostService.updatePost(
        context,
        postId,
        pickedImage!,
        titleCtrl.text,
        descCtrl.text,
        priceParse,
        lat!,
        lon!,
        amountParse,
        rating,
        selectedCategory,
        rules,
      );

      isLoading = false;
      notifyListeners();

      if (!context.mounted) return;
      context.pop();
      await getPostProv.refreshPost(context);
      await getUserPostProv.getUserPost();

      if (!context.mounted) return;
      customSnackBar(context, 'Edit barang berhasil');
    } catch (e) {
      isLoading = false;
      notifyListeners();
      customSnackBar(context, 'Edit barang gagal');
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
