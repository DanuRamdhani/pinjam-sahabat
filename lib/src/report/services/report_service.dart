import 'package:pinjam_sahabat/helper/firebase_helper.dart';

class ReportService {
  static Future<void> createReport(String message, String postId) async {
    final userId = auth.currentUser?.uid;

    await db.collection('report').add({
      'message': message,
      'postId': postId,
      'userIdReport': userId,
    });
  }
}
