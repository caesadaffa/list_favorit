import 'package:get/get.dart';
import 'package:list_favorit/routes/route_name.dart';

import '../favourite/favorit.dart';
import '../favourite/favoritBinding.dart';
import '../home/Home.dart';
import '../home/homeBinding.dart';

class AppPages {

  static const INITIAL = RouteName.home;

  static final pages = [
    GetPage(
      name: RouteName.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteName.favorite,
      page: () => FavoritePage(),
      binding: FavoriteBinding(),
    ),
  ];
}