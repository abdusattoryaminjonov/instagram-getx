import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/post_model.dart';
import '../services/db_service.dart';
import '../services/utils_service.dart';

class FeedController extends GetxController{
  bool isLoading = false;
  List<Post> items = [];

  void apiPostLike(Post post) async {
    isLoading = true;
    update();

    await DBService.likePost(post, true);
    isLoading = false;
    post.liked = true;
    update();
  }
  dialogRemovePost(Post post,BuildContext context) async {
    var result = await Utils.dialogCommon(context, "Instagram", "Do you want to detele this post?", false);

    if (result) {
      isLoading = true;
      update();

      DBService.removePost(post).then((value) => {
        apiLoadFeeds(),
      });
    }
  }

  void apiPostUnLike(Post post) async {
    isLoading = true;
    update();

    await DBService.likePost(post, false);
    isLoading = false;
    post.liked = false;
    update();
  }

  apiLoadFeeds() {
    isLoading = true;
    update();

    DBService.loadFeeds().then((value) => {
      resLoadFeeds(value),
    });
  }

  resLoadFeeds(List<Post> posts) {
    items = posts;
    isLoading = false;
    update();
  }
}