import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/user_post/providers/add_post.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/user_post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/pick_image_dialog.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/place_mark.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/rules.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/select_category.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPostProvider>(
      builder: (context, addPostProv, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tambah Barang'),
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const FaIcon(FontAwesomeIcons.angleLeft),
            ),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Nama Barang :',
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: addPostProv.titleCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nama Barang',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Kategori :',
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: 4),
                const SelectCategory(),
                const SizedBox(height: 16),
                Text(
                  'Harga :',
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: addPostProv.priceCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Harga per hari',
                    helperText: '(gratis) tidak menambahkan harga',
                    helperMaxLines: 2,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Jumlah :',
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: addPostProv.amountCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Barang',
                    helperText: '(1) tidak menambahkan jumlah',
                    helperMaxLines: 2,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Deskripsi :',
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: 4),
                TextFormField(
                  maxLines: 3,
                  controller: addPostProv.descCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi barang',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Peraturan :',
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 250,
                  child: Rules(rules: addPostProv.rules),
                ),
                const SizedBox(height: 16),
                Container(
                  height: context.width,
                  width: context.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.color.primary.withOpacity(.4),
                    ),
                    borderRadius: BorderRadius.circular(8),
                    image: addPostProv.pickedImage != null
                        ? DecorationImage(
                            image: FileImage(addPostProv.pickedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: addPostProv.pickedImage == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.image,
                                color: context.color.primary.withOpacity(.4),
                                size: 80,
                              ),
                              Text(
                                "No Image",
                                style: context.text.headlineMedium!.copyWith(
                                  color: context.color.primary.withOpacity(.4),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () => showPickImageDialog(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    textStyle: context.text.titleSmall,
                  ),
                  child: const Text('Ambil Gambar'),
                ),
                TextButton.icon(
                  onPressed: () => context.pushNamed(AppRoute.googleMap),
                  icon: const Icon(Icons.location_on),
                  label: const Text('Tambahkan lokasi barang'),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Consumer<LocationProvider>(
                  builder: (context, locProv, child) {
                    if (locProv.placemark != null) {
                      return Placemark(
                        placemark: locProv.placemark!,
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: context.width,
                  child: ElevatedButton(
                    onPressed: addPostProv.isUploading
                        ? () {}
                        : () => addPostProv.uploadPost(context),
                    child: addPostProv.isUploading
                        ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeCap: StrokeCap.round,
                            ),
                          )
                        : const Text('Upload'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
