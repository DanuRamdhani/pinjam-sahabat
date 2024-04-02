import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/src/home/services/rating_service.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class RatingProvider extends ChangeNotifier {
  int rating = 0;
  bool isLoading = false;

  void setRating(int chosenRating) {
    rating = chosenRating;
    notifyListeners();
  }

  Future<void> giveRating(
    BuildContext context,
    String postId,
    int givedRating,
  ) async {
    final getPostProv = context.read<GetPostProvider>();

    try {
      isLoading = true;
      notifyListeners();

      await RatingService.updateRating(postId, givedRating);

      isLoading = false;
      notifyListeners();

      if (!context.mounted) return;
      Navigator.of(context)
          .popUntil((route) => route.settings.name == AppRoute.mainWrapper);

      getPostProv.refreshPost(context);
      customSnackBar(context, 'memberi rating berhasil');
    } catch (e) {
      isLoading = false;
      notifyListeners();
      customSnackBar(context, 'gagal memberi rating');
    }
  }
}
