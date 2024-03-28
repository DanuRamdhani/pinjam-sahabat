import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/user_post/providers/delete_user_post.dart';
import 'package:provider/provider.dart';

void deletePostDialog(BuildContext context, String postId) {
  final deletePost = context.read<DeleteUserPostProvider>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.only(right: 8, left: 24, top: 8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Hapus barang'),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        content: ElevatedButton(
          onPressed: () => deletePost.deletePost(context, postId),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          child: const Text('Hapus'),
        ),
      );
    },
  );
}
