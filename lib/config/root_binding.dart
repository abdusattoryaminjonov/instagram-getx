import 'package:get/get.dart';

import '../controllers/feed_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/like_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/search_controller.dart';
import '../controllers/signin_controller.dart';
import '../controllers/signup_controller.dart';
import '../controllers/splash_controller.dart';
import '../controllers/upload_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => FeedController(), fenix: true);
    Get.lazyPut(() => SearcherController(), fenix: true);
    Get.lazyPut(() => UploadController(), fenix: true);
    Get.lazyPut(() => LikeController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => SignInController(), fenix: true);
  }
}