import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post_model.dart';
import '../services/db_service.dart';
import '../services/file_service.dart';

class UploadController extends GetxController{
  bool isLoading = false;
  var captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? imageFile;


  xButton(){
    imageFile = null;
    update();
  }

  moveToFeed(PageController pageController) {
    isLoading = false;
    update();

    captionController.text = "";
    imageFile = null;
    pageController.animateToPage(
        0, duration: const Duration(microseconds: 200), curve: Curves.easeIn);
  }

  imgFromGallery() async {
    XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    imageFile = File(image!.path);
    update();
  }

  imgFromCamera() async {
    XFile? image =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    imageFile = File(image!.path);
    update();
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Pick Photo'),
                    onTap: () {
                      imgFromGallery();
                      Get.back();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Take Photo'),
                  onTap: () {
                    imgFromCamera();
                    Get.back();
                  },
                ),
              ],
            ),
          );
        });
  }

  uploadNewPost(PageController pageController) {
    String caption = captionController.text.toString().trim();
    if (caption.isEmpty) return;
    if (imageFile == null) return;
    apiPostImage(pageController);
  }

  void apiPostImage(PageController pageController){
    isLoading = true;
    update();

    FileService.uploadPostImage(imageFile!).then((downloadUrl) => {
      resPostImage(downloadUrl,pageController),
    });
  }

  void resPostImage(String downloadUrl,PageController pageController){
    String caption = captionController.text.toString().trim();
    Post post = Post(caption, downloadUrl);
    apiStorePost(post,pageController);
  }

  void apiStorePost(Post post,PageController pageController)async{
    // Post to posts
    Post posted = await DBService.storePost(post);
    // Post to feeds
    DBService.storeFeed(posted).then((value) => {
      moveToFeed(pageController),
    });
  }
}