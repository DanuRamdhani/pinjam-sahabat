import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';
import 'package:pinjam_sahabat/src/home/models/rent_item.dart';

class RentService {
  static Future<void> createOrder(
    String postId,
    String ordererUserId,
    String userName,
    String ordererPhoneNumber,
    int totalPrice,
    Timestamp firstDate,
    Timestamp lastDate,
    int amountOrder,
    bool status,
  ) async {
    db.collection('rent').add(
          RentItem(
            createdAt: Timestamp.now(),
            postId: postId,
            ordererUserId: ordererUserId,
            userName: userName,
            ordererPhoneNumber: ordererPhoneNumber,
            totalPrice: totalPrice,
            firstDate: firstDate,
            lastDate: lastDate,
            amountOrder: amountOrder,
            status: status,
          ).toFirestore(),
        );
  }
}
