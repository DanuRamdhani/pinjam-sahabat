import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/post/providers/get_post.dart';
import 'package:pinjam_sahabat/src/post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/post/services/post_service.dart';
import 'package:pinjam_sahabat/src/main_wrapper/providers/main_wrapper_provider.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class AddPostProvider extends ChangeNotifier {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  File? pickedImage;
  List<String> selectedCategory = [];
  bool isUploading = false;

  double? lat;
  double? lon;

  void goToAddDetail(BuildContext context) {
    if (titleCtrl.text.trim().isEmpty ||
        descCtrl.text.isEmpty ||
        pickedImage == null) {
      customSnackBar(context, 'Isi semua textfield');
      return;
    }
    context.pushNamed(AppRoute.addPostDetail);
  }

  Future<void> uploadPost(BuildContext context) async {
    final mainWrapperProv = context.read<MainWrapperProvider>();
    final getPostProv = context.read<GetPostProvider>();

    try {
      isUploading = true;
      notifyListeners();
      if (lat == null || lon == null) {
        customSnackBar(context, 'Pilih lokasi anda');
        return;
      }

      if (selectedCategory.isEmpty) {
        customSnackBar(context, 'Tambahkan minimal 1 kategori');
        return;
      }

      if (priceCtrl.text.trim().isEmpty) {
        priceCtrl.text = '0';
      }

      final priceParse = int.parse(priceCtrl.text);
      await PostService.createPost(
        context,
        pickedImage!,
        titleCtrl.text,
        descCtrl.text,
        priceParse,
        lat!,
        lon!,
        selectedCategory,
      );

      if (!context.mounted) return;
      Navigator.of(context).popUntil(
        (route) => route.settings.name == AppRoute.mainWrapper,
      );
      mainWrapperProv.onItemTapped(context, 0);
      await getPostProv.refreshPost(context);

      titleCtrl.clear();
      descCtrl.clear();
      priceCtrl.clear();
      pickedImage = null;
      selectedCategory = [];
      lat = null;
      lon = null;

      isUploading = false;
      notifyListeners();
    } catch (e) {
      isUploading = false;
      notifyListeners();
      if (!context.mounted) return;
      customSnackBar(context, 'Add post succed');
    }
  }

  Future<void> takeImageGallery(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    pickedImage = File(image.path);
    notifyListeners();
  }

  Future<void> takeImageCamera(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    pickedImage = File(image.path);
    notifyListeners();
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
