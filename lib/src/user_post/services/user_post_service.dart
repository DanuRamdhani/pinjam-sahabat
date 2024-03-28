import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';

class UserPostService {
  static Future<QuerySnapshot<Map<String, dynamic>>> getUserPost() async {
    final userId = auth.currentUser?.uid;

    final result = await db
        .collection('post')
        .orderBy('createdAt', descending: true)
        .where('userId', isEqualTo: userId)
        .limit(10)
        .get();

    return result;
  }

  static Future<void> createPost(
    BuildContext context,
    File file,
    String title,
    String desc,
    int price,
    num lat,
    num lon,
    int amount,
    List<String> category,
    List<String> rules,
  ) async {
    final userId = auth.currentUser!.uid;
    final postId= db.collection('post').doc().id;

    final ref = storage.ref();
    final postRef =
        ref.child('all-post/$userId/$postId.jpg');

    await postRef.putFile(file);
    final imageUrl = await postRef.getDownloadURL();

    await db.collection('post').doc(postId).set(
          Post(
            userId: userId,
            createdAt: Timestamp.now(),
            title: title,
            desc: desc,
            image: imageUrl,
            price: price,
            lat: lat,
            lon: lon,
            amount: amount,
            rating: 0,
            category: category,
            rules: rules,
          ).toFirestore(),
        );
  }

  static Future<void> updatePost(
    BuildContext context,
    String postId,
    File file,
    String title,
    String desc,
    int price,
    num lat,
    num lon,
    int amount,
    num rating,
    List<String> category,
    List<String> rules,
  ) async {
    final userId = auth.currentUser!.uid;

    final ref = storage.ref();
    final postRef = ref.child('all-post/$userId/$postId.jpg');

    await postRef.delete();
    await postRef.putFile(file);
    final imageUrl = await postRef.getDownloadURL();

    await db.collection('post').doc(postId).update(
          Post(
            userId: userId,
            createdAt: Timestamp.now(),
            title: title,
            desc: desc,
            image: imageUrl,
            price: price,
            lat: lat,
            lon: lon,
            amount: amount,
            rating: rating,
            category: category,
            rules: rules,
          ).toFirestore(),
        );
  }

  static Future<void> deleteUserPost(String postId) async {
    final userId = auth.currentUser!.uid;

    final ref = storage.ref();
    final postRef = ref.child('all-post/$userId/$postId.jpg');

    await postRef.delete();

    final snapshot =
        await db.collection('rent').where('postId', isEqualTo: postId).get();

    for (var rentDoc in snapshot.docs) {
      await rentDoc.reference.delete();
    }

    await db.collection('post').doc(postId).delete();
  }
}
