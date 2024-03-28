import 'package:cloud_firestore/cloud_firestore.dart';

class RentItem {
  RentItem({
    this.rentId,
    required this.createdAt,
    required this.postId,
    required this.ordererUserId,
    required this.userName,
    required this.ordererPhoneNumber,
    required this.totalPrice,
    required this.firstDate,
    required this.lastDate,
    required this.amountOrder,
    required this.status,
  });

  final String? rentId;
  final Timestamp createdAt;
  final String postId;
  final String ordererUserId;
  final String userName;
  final String ordererPhoneNumber;
  final int totalPrice;
  final Timestamp firstDate;
  final Timestamp lastDate;
  final int amountOrder;
  final bool status;

  factory RentItem.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return RentItem(
      rentId: snapshot.id,
      createdAt: data['createdAt'],
      postId: data['postId'],
      userName: data['userName'],
      ordererUserId: data['ordererUserId'],
      ordererPhoneNumber: data['ordererPhoneNumber'],
      totalPrice: data['totalPrice'],
      firstDate: data['firstDate'],
      lastDate: data['lastDate'],
      amountOrder: data['amountOrder'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'createdAt': createdAt,
      'postId': postId,
      'userName': userName,
      'ordererUserId': ordererUserId,
      'ordererPhoneNumber': ordererPhoneNumber,
      'totalPrice': totalPrice,
      'firstDate': firstDate,
      'lastDate': lastDate,
      'amountOrder': amountOrder,
      'status': status,
    };
  }
}
