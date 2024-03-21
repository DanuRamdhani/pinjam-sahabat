import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/post/providers/add_post.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPostProvider>(
      builder: (context, addPostProv, _) {
        return Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Nama',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.color.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: addPostProv.titleCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nama Barang',
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Deskripsi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.color.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  maxLines: 3,
                  controller: addPostProv.descCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi barang',
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: context.width,
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
                              Icons.image_outlined,
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
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: () => addPostProv.takeImageCamera(context),
                    icon: const Icon(Icons.photo_camera),
                  ),
                  IconButton.filledTonal(
                    onPressed: () => addPostProv.takeImageGallery(context),
                    icon: const Icon(Icons.photo_library_rounded),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: context.color.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: addPostProv.priceCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Harga per hari',
                          helperText: '(gratis) tidak menambahkan harga',
                          helperMaxLines: 2,
                          border: InputBorder.none,
                          alignLabelWithHint: true,
                          isCollapsed: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => addPostProv.goToAddDetail(context),
                child: const Text('Lanjut'),
              ),
            ],
          ),
        );
      },
    );
  }
}
