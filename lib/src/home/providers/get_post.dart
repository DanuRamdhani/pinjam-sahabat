import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/models/response.dart';
import 'package:pinjam_sahabat/src/home/services/post_service.dart';
import 'package:pinjam_sahabat/utils/categories.dart';

class GetPostProvider extends ChangeNotifier {
  List<Post> listFreePost = [];
  List<Post> listPaidPost = [];
  ResponseState responseState = ResponseState.initial;
  String selectedCategory = categories.first;

  Future<void> getAllPost(BuildContext context) async {
    try {
      listFreePost.clear();
      listPaidPost.clear();
      selectedCategory = categories.first;
      notifyListeners();

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
    responseState = ResponseState.loading;
    notifyListeners();

    try {
      listFreePost.clear();
      listPaidPost.clear();

      if (selectedCategory == categories.first) {
        final snapshotFree = await GetPostService.getAllFreePost();
        final snapshotPaid = await GetPostService.getAllPaidPost();

        for (var post in snapshotFree.docs) {
          listFreePost.add(Post.fromFirestore(post));
        }
        for (var post in snapshotPaid.docs) {
          listPaidPost.add(Post.fromFirestore(post));
        }
      } else {
        final snapshotFree =
            await GetPostService.getFreePostByCategory(selectedCategory);
        final snapshotPaid =
            await GetPostService.getPaidPostByCategory(selectedCategory);

        for (var post in snapshotFree.docs) {
          listFreePost.add(Post.fromFirestore(post));
        }
        for (var post in snapshotPaid.docs) {
          listPaidPost.add(Post.fromFirestore(post));
        }
      }

      responseState = ResponseState.succes;
      notifyListeners();
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
