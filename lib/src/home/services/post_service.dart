import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';

class GetPostService {
  static Future<QuerySnapshot<Map<String, dynamic>>> getAllFreePost() async {
    final snapshot = await db
        .collection('post')
        .where('price', isEqualTo: 0)
        .limit(10)
        .get();

    return snapshot;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllPaidPost() async {
    final snapshot = await db
        .collection('post')
        .where('price', isNotEqualTo: 0)
        .limit(10)
        .get();

    return snapshot;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getFreePostByCategory(
    String category,
  ) async {
    final result = await db
        .collection('post')
        .where('price', isEqualTo: 0)
        .where('category', arrayContains: category)
        .limit(10)
        .get();

    return result;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getPaidPostByCategory(
    String category,
  ) async {
    final result = await db
        .collection('post')
        .where('price', isNotEqualTo: 0)
        .where('category', arrayContains: category)
        .limit(10)
        .get();

    return result;
  }
}
