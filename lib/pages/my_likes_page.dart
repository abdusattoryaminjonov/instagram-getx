import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclon/controllers/like_controller.dart';
import '../views/item_of_like_post.dart';


class MyLikesPage extends StatefulWidget {
  const MyLikesPage({Key? key}) : super(key: key);

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  final likeController = Get.find<LikeController>();

  @override
  void initState() {
    super.initState();
    likeController.apiLoadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Likes",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
        ),
      ),
      body: GetBuilder<LikeController>(
        builder: (_){
          return Stack(
            children: [
              ListView.builder(
                itemCount: likeController.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfLikePost(likeController.items[index],likeController,context);
                },
              ),
              likeController.isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : const SizedBox.shrink(),
            ],
          );
        },
      )
    );
  }

}