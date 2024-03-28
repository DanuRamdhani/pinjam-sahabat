import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/models/response.dart';
import 'package:pinjam_sahabat/src/user_post/services/user_post_service.dart';

class GetUserPostProvider extends ChangeNotifier {
  List<Post> listUserPost = [];
  ResponseState responseState = ResponseState.initial;

  Future<void> getUserPost() async {
    responseState = ResponseState.loading;

    try {
      listUserPost.clear();

      final snapshot = await UserPostService.getUserPost();

      for (var post in snapshot.docs) {
        listUserPost.add(Post.fromFirestore(post));
      }

      responseState = ResponseState.succes;
      notifyListeners();
    } catch (e) {
      responseState = ResponseState.fail;
      notifyListeners();
    }
  }
}
