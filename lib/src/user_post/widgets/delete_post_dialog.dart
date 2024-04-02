import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/user_post/providers/delete_user_post.dart';
import 'package:provider/provider.dart';

void deletePostDialog(BuildContext context, String postId) {
  showDialog(
    context: context,
    builder: (context) {
      return Consumer<DeleteUserPostProvider>(
        builder: (context, deletePost, _) {
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
              onPressed: deletePost.isLoading
                  ? null
                  : () => deletePost.deletePost(context, postId),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: deletePost.isLoading
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Text('Hapus'),
            ),
          );
        },
      );
    },
  );
}
