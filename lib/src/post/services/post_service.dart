import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/post/models/post.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';

class PostService {
  static Future<void> createPost(
    BuildContext context,
    File file,
    String title,
    String desc,
    int price,
    num lat,
    num lon,
    List<String> category,
  ) async {
    final userId = auth.currentUser!.uid;

    final ref = storage.ref();
    final postRef =
        ref.child('all-post/$userId/${db.collection('post').doc().id}.jpg');

    await postRef.putFile(file);
    final imageUrl = await postRef.getDownloadURL();

    await db.collection('post').add(
          Post(
            userId: userId,
            createdAt: Timestamp.now(),
            title: title,
            desc: desc,
            image: imageUrl,
            price: price,
            lat: lat,
            lon: lon,
            rating: 0,
            category: category,
          ).toFirestore(),
        );
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getAllPost(
    List<Post> listPost,
  ) async {
    if (listPost.isEmpty) {
      final snapshot = await db
          .collection('post')
          .orderBy('createdAt', descending: true)
          .limit(5)
          .get();

      return snapshot;
    } else {
      final snapshot = await db
          .collection('post')
          .orderBy('createdAt', descending: true)
          .startAfter([listPost.last.createdAt])
          .limit(5)
          .get();

      return snapshot;
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getPostByCategory(
    String category,
  ) async {
    final result = await db
        .collection('post')
        .where('category', arrayContains: category)
        .limit(20)
        .get();

    return result;
  }
}
