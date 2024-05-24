import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  PageController? pageController;
  int currentTap = 0;

  changeCurrentTap(int index) {
    currentTap = index;
    update();
  }

  animationButton(int index){
    currentTap = index;
    pageController!.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

}