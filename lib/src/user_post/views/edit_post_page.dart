import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/edit_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/edit_select_category.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/pick_image_dialog.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/place_mark.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/rules.dart';
import 'package:provider/provider.dart';

class EditPostPage extends StatefulWidget {
  const EditPostPage({super.key, required this.post});

  final Post post;

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  @override
  void initState() {
    final locProv = context.read<LocationProvider>();
    final editPostProv = context.read<EditPostProvider>();

    editPostProv.initializePostData(
      title: widget.post.title,
      price: widget.post.price.toString(),
      amount: widget.post.amount.toString(),
      description: widget.post.desc,
      categoriesFromPost: widget.post.category,
      latPost: widget.post.lat as double,
      lonPost: widget.post.lon as double,
    );

    Future.microtask(
      () => locProv.onGetPostLocation(
        context,
        LatLng(
          widget.post.lat as double,
          widget.post.lon as double,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditPostProvider>(
      builder: (context, editPostProv, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Barang'),
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
                  controller: editPostProv.titleCtrl,
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
                const EditSelectCategory(),
                const SizedBox(height: 16),
                Text(
                  'Harga :',
                  style: context.text.titleMedium,
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: editPostProv.priceCtrl,
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
                  controller: editPostProv.amountCtrl,
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
                  controller: editPostProv.descCtrl,
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
                  child: Rules(rules: widget.post.rules),
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
                    image: editPostProv.pickedImage != null
                        ? DecorationImage(
                            image: FileImage(editPostProv.pickedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: editPostProv.pickedImage == null
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
                  onPressed: () => showPickImageDialog(context, true),
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
                  onPressed: () =>
                      context.pushNamed(AppRoute.googleMap, widget.post),
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
                    onPressed: editPostProv.isLoading
                        ? () {}
                        : () => editPostProv.updatePost(
                              context,
                              widget.post.postId!,
                              widget.post.rating,
                            ),
                    child: editPostProv.isLoading
                        ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeCap: StrokeCap.round,
                            ),
                          )
                        : const Text('Edit'),
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
