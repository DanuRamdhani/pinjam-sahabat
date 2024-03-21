import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/post/models/post.dart';
import 'package:pinjam_sahabat/src/post/models/response.dart';
import 'package:pinjam_sahabat/src/post/services/post_service.dart';
import 'package:pinjam_sahabat/utils/categories.dart';

class GetPostProvider extends ChangeNotifier {
  List<Post> listPost = [];
  List<Post> listPostCategory = [];
  ResponseStatePost responseState = ResponseStatePost.initial;
  int resultLenght = 0;

  String selectedCategory = categories.first;
  bool isCategorySelected = false;

  Future<void> getAllPost(BuildContext context) async {
    try {
      final snapshot = await PostService.getAllPost(listPost);

      resultLenght = snapshot.docs.length;

      for (var post in snapshot.docs) {
        listPost.add(Post.fromFirestore(post));
      }

      responseState = ResponseStatePost.succes;
      notifyListeners();
    } catch (e) {
      responseState = ResponseStatePost.fail;
      notifyListeners();
    }
  }

  Future<void> refreshPost(BuildContext context) async {
    responseState = ResponseStatePost.loading;
    notifyListeners();

    try {
      listPost.clear();
      final snapshot = await PostService.getAllPost(listPost);

      for (var post in snapshot.docs) {
        listPost.add(
          Post.fromFirestore(post),
        );
      }

      responseState = ResponseStatePost.succes;
      notifyListeners();
    } catch (e) {
      responseState = ResponseStatePost.fail;
      notifyListeners();
    }
  }

  Future<void> getPostByCategory(BuildContext context, String category) async {
    responseState = ResponseStatePost.loading;

    try {
      listPostCategory.clear();
      selectedCategory = category;

      final snapshot = await PostService.getPostByCategory(
        selectedCategory,
      );

      resultLenght = snapshot.docs.length;

      snapshot.docs.shuffle();
      for (var post in snapshot.docs) {
        listPostCategory.add(
          Post.fromFirestore(post),
        );
      }

      responseState = ResponseStatePost.succes;
      notifyListeners();
    } catch (e) {
      responseState = ResponseStatePost.fail;
      notifyListeners();
    }
  }
}
