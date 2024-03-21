import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/post/providers/add_post.dart';
import 'package:pinjam_sahabat/src/post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/post/widgets/place_mark.dart';
import 'package:pinjam_sahabat/utils/categories.dart';
import 'package:provider/provider.dart';

class AddPostDetailPage extends StatelessWidget {
  const AddPostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post Detail'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer2<AddPostProvider, LocationProvider>(
            builder: (context, addPostProv, locProv, _) {
              return Stack(
                children: [
                  ListView(
                    children: [
                      MultiSelectDialogField(
                        decoration: BoxDecoration(
                          border: null,
                          color: context.color.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        items: categories
                            .map((e) => MultiSelectItem(e, e))
                            .toList(),
                        listType: MultiSelectListType.LIST,
                        onConfirm: (values) {
                          addPostProv.selectedCategory = values;
                        },
                        buttonText: const Text('Pilih Kategori'),
                        chipDisplay: MultiSelectChipDisplay(
                          chipColor: context.color.primaryContainer,
                          textStyle: TextStyle(
                            color: context.color.onPrimaryContainer,
                          ),
                          items: addPostProv.selectedCategory
                              .map((e) => MultiSelectItem(e, e))
                              .toList(),
                          onTap: (value) =>
                              addPostProv.deleteSelectedCategory(value),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton.icon(
                        onPressed: () => context.pushNamed(AppRoute.googleMap),
                        icon: const Icon(Icons.location_on),
                        label: const Text('Tambahkan lokasi barang anda'),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      if (locProv.placemark != null)
                        Placemark(
                          placemark: locProv.placemark!,
                        ),
                    ],
                  ),
                  Positioned(
                    bottom: 16,
                    child: SizedBox(
                      width: context.width - 32,
                      child: ElevatedButton(
                        onPressed: addPostProv.isUploading
                            ? () {}
                            : () => addPostProv.uploadPost(context),
                        child: addPostProv.isUploading
                            ? const SizedBox.square(
                                dimension: 16,
                                child: CircularProgressIndicator(
                                  strokeCap: StrokeCap.round,
                                ),
                              )
                            : const Text('Upload'),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
