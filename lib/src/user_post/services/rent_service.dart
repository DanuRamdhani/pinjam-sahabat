import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';

class GetRentService {
  static Future<QuerySnapshot<Map<String, dynamic>>> getRentUser(
      String postId) async {
    final result = await db
        .collection('rent')
        .orderBy('createdAt', descending: true)
        .where('postId', isEqualTo: postId)
        .get();

    return result;
  }

  static Future<void> updateStatus(
      String rentId, bool status, String postId, int amountAfter) async {
    await db.collection('rent').doc(rentId).update({
      'status': !status,
    });

    await db.collection('post').doc(postId).update({
      'amount': amountAfter,
    });
  }
}
