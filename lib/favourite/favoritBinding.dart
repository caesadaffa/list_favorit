import 'package:get/get.dart';

import 'favoritController.dart';

class FavoriteBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<FavoriteController>(() => FavoriteController());
  }
}