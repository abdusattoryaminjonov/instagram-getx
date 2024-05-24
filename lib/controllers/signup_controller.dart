import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclon/pages/home_page.dart';

import '../models/member_model.dart';
import '../pages/signin_page.dart';
import '../services/auth_service.dart';
import '../services/db_service.dart';
import '../services/prefs_service.dart';
import '../services/utils_service.dart';

class SignUpController extends GetxController{
  var isLoading = false;
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();


  doSignUp(BuildContext context){
    String name = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(name.isEmpty || email.isEmpty || password.isEmpty) return;

    isLoading = true;
    update();

    AuthService.signUpUser(context, name, email, password).then((firebaseUser) => {
      getFirebaseUser(firebaseUser!, Member(name, email)),
    });
  }
  getFirebaseUser(User? firebaseUser,Member member) async {
    isLoading = false;
    update();

    if (firebaseUser != null) {
      await Prefs.saveUserId(firebaseUser.uid);
      saveMemberIdToLocal(firebaseUser);
      saveMemberToCloud(member);

      callHomePage();
    } else {
      Utils.fireToast("Check your information",Colors.red);
    }
  }

  saveMemberIdToLocal(User firebaseUser)async{
    await Prefs.saveUserId(firebaseUser.uid);
  }
  saveMemberToCloud(Member member) async{
    await DBService.storeMember(member);
  }

  callHomePage(){
    Get.offNamed(HomePage.id);
  }

  callSignInPage(){
    Get.offNamed(SignInPage.id);
  }
}