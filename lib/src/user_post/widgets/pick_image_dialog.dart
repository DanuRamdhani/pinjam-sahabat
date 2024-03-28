import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/user_post/providers/add_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/edit_post_provider.dart';
import 'package:provider/provider.dart';

void showPickImageDialog(BuildContext context, [bool isEdit = false]) {
  final addPostProv = context.read<AddPostProvider>();
  final editPostProv = context.read<EditPostProvider>();

  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: const Text(
          'Pilih gambar dari',
          textAlign: TextAlign.center,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton.filledTonal(
                    onPressed: () => isEdit
                        ? editPostProv.takeImageCamera(context)
                        : addPostProv.takeImageCamera(context),
                    icon: const Icon(Icons.photo_camera),
                  ),
                  const Text('Kamera'),
                ],
              ),
              const SizedBox(width: 24),
              Column(
                children: [
                  IconButton.filledTonal(
                    onPressed: () => isEdit
                        ? editPostProv.takeImageGallery(context)
                        : addPostProv.takeImageGallery(context),
                    icon: const Icon(Icons.photo_library_rounded),
                  ),
                  const Text('Galeri'),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      );
    },
  );
}
