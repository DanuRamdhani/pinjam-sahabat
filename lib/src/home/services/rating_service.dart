import 'package:pinjam_sahabat/helper/firebase_helper.dart';

class RatingService {
  static Future<void> updateRating(String postId, int givedRating) async {
    final result = await db.collection('post').doc(postId).get();

    final postRating = result.data()!['rating'];

    var resultRating = (postRating + givedRating) / 2;

    if (postRating == 0) {
      resultRating = givedRating;
    }

    await db.collection('post').doc(postId).update({'rating': resultRating});
  }
}
