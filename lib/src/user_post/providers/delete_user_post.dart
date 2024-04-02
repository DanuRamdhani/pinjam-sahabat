import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_user_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/services/user_post_service.dart';
import 'package:pinjam_sahabat/utils/categories.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class DeleteUserPostProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> deletePost(BuildContext context, String postId) async {
    final getUserPost = context.read<GetUserPostProvider>();
    final getPost = context.read<GetPostProvider>();

    isLoading = true;
    notifyListeners();
    try {
      await UserPostService.deleteUserPost(postId);

      if (!context.mounted) return;
      if (getPost.selectedCategory == categories.first) {
        await getPost.getAllPost(context);
      } else {
        await getPost.getPostByCategory(context, getPost.selectedCategory);
      }
      await getUserPost.getUserPost();
      isLoading = false;
      notifyListeners();
      if (!context.mounted) return;
      customSnackBar(context, 'berhasil menghapus barang');
      context.pop();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      customSnackBar(context, 'gagal menghapus barang');
    }
  }
}
