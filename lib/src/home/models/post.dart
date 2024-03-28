import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    this.postId,
    required this.userId,
    required this.createdAt,
    required this.title,
    required this.desc,
    required this.image,
    required this.price,
    required this.lat,
    required this.lon,
    required this.rating,
    required this.amount,
    required this.category,
    required this.rules,
  });

  final String? postId;
  final String userId;
  final Timestamp createdAt;
  final String title;
  final String desc;
  final String image;
  final int price;
  final num lat;
  final num lon;
  final num rating;
  final int amount;
  final List<String> category;
  final List<String> rules;

  factory Post.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot;
    return Post(
      postId: data.id,
      userId: data['userId'],
      createdAt: data['createdAt'],
      title: data['title'],
      desc: data['desc'],
      image: data['image'],
      price: data['price'],
      lat: data['lat'],
      lon: data['lon'],
      rating: data['rating'],
      amount: data['amount'],
      category: List.from(data['category']),
      rules: List.from(data['rules']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'createdAt': createdAt,
      'title': title,
      'desc': desc,
      'image': image,
      'price': price,
      'lat': lat,
      'lon': lon,
      'rating': rating,
      'amount': amount,
      'category': category,
      'rules': rules,
    };
  }
}
