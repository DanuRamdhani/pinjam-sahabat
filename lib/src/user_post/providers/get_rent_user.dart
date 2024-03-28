import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/models/rent_item.dart';
import 'package:pinjam_sahabat/src/home/models/response.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_user_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/services/rent_service.dart';
import 'package:pinjam_sahabat/utils/categories.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class GetRentUserProvider extends ChangeNotifier {
  List<RentItem> listRentUser = [];
  ResponseState responseState = ResponseState.initial;

  Future<void> getRentUser(String postId) async {
    responseState = ResponseState.loading;
    notifyListeners();

    try {
      listRentUser.clear();

      final snapshot = await GetRentService.getRentUser(postId);

      for (var post in snapshot.docs) {
        listRentUser.add(RentItem.fromFirestore(post));
      }

      responseState = ResponseState.succes;
      notifyListeners();
    } catch (e) {
      responseState = ResponseState.fail;
      notifyListeners();
    }
  }

  Future<void> updateStatus(
    BuildContext context,
    String rentId,
    bool status,
    String postId,
    int amountAfter,
  ) async {
    final getUserPost = context.read<GetUserPostProvider>();
    final getPost = context.read<GetPostProvider>();

    try {
      await GetRentService.updateStatus(rentId, status, postId, amountAfter);
      if (!context.mounted) return;
      if (getPost.selectedCategory == categories.first) {
        await getPost.getAllPost(context);
      } else {
        await getPost.getPostByCategory(context, getPost.selectedCategory);
      }
      await getUserPost.getUserPost();
      if (!context.mounted) return;
      customSnackBar(context, 'berhasil mengubah status');
      Navigator.popUntil(
          context, (route) => route.settings.name == AppRoute.mainWrapper);
    } catch (e) {
      customSnackBar(context, 'gagal mengubah status');
      context.pop();
    }
  }
}
