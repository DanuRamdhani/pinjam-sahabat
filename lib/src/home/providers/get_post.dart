import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/models/response.dart';
import 'package:pinjam_sahabat/src/home/services/post_service.dart';
import 'package:pinjam_sahabat/utils/categories.dart';

class GetPostProvider extends ChangeNotifier {
  List<Post> listFreePost = [];
  List<Post> listPaidPost = [];
  List<Post> listAllPost = [];
  ResponseState responseState = ResponseState.initial;
  String selectedCategory = categories.first;

  Future<void> getPostForSearching() async {
    listAllPost.clear();
    final snapshot = await GetPostService.getAllPost();

    for (var post in snapshot.docs) {
      listAllPost.add(Post.fromFirestore(post));
    }
  }

  Future<void> getAllPost(BuildContext context) async {
    responseState = ResponseState.loading;

    try {
      listFreePost.clear();
      listPaidPost.clear();
      selectedCategory = categories.first;
      notifyListeners();

      await getPostForSearching();
      final snapshotFree = await GetPostService.getAllFreePost();
      final snapshotPaid = await GetPostService.getAllPaidPost();

      snapshotFree.docs.shuffle();
      snapshotPaid.docs.shuffle();

      for (var post in snapshotFree.docs) {
        listFreePost.add(Post.fromFirestore(post));
      }
      for (var post in snapshotPaid.docs) {
        listPaidPost.add(Post.fromFirestore(post));
      }

      responseState = ResponseState.succes;
      notifyListeners();
    } catch (e) {
      responseState = ResponseState.fail;
      notifyListeners();
    }
  }

  Future<void> refreshPost(BuildContext context) async {
    try {
      if (selectedCategory == categories.first) {
        await getAllPost(context);
      } else {
        await getPostByCategory(context, selectedCategory);
        await getPostForSearching();
      }
    } catch (e) {
      responseState = ResponseState.fail;
      notifyListeners();
    }
  }

  Future<void> getPostByCategory(BuildContext context, String category) async {
    responseState = ResponseState.loading;

    try {
      listFreePost.clear();
      listPaidPost.clear();
      selectedCategory = category;
      notifyListeners();

      final snapshotFree =
          await GetPostService.getFreePostByCategory(selectedCategory);
      final snapshotPaid =
          await GetPostService.getPaidPostByCategory(selectedCategory);

      snapshotFree.docs.shuffle();
      snapshotPaid.docs.shuffle();

      for (var post in snapshotFree.docs) {
        listFreePost.add(Post.fromFirestore(post));
      }
      for (var post in snapshotPaid.docs) {
        listPaidPost.add(Post.fromFirestore(post));
      }

      responseState = ResponseState.succes;
      notifyListeners();
    } catch (e) {
      responseState = ResponseState.fail;
      notifyListeners();
    }
  }
}
