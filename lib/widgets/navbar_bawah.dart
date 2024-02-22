import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_name.dart';

class NavbarBawah extends StatelessWidget {
  final Color pressedIcon;

  NavbarBawah({required this.pressedIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: nav(context, pressedIcon),
    );
  }
}

Widget nav(BuildContext context, Color color){

  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Container(
    padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.home, color: color),
          onPressed: () {
            Get.offNamed(RouteName.home);
          },
        ),
        IconButton(
          icon: Icon(Icons.favorite, color: color),
          onPressed: () {
            Get.offNamed(RouteName.favorite);
          },
        ),
        // IconButton(
        //   icon: Icon(Icons.home, color: activePage == RouteName.home ? Colors.red : color),
        //   onPressed: () {
        //     Get.offNamed(RouteName.home);
        //   },
        // ),
        // IconButton(
        //   icon: Icon(Icons.favorite, color: activePage == RouteName.favorite ? Colors.red : color),
        //   onPressed: () {
        //     Get.offNamed(RouteName.favorite);
        //   },
        // ),
        // IconButton(
        //   icon: Icon(Icons.person, color: activePage == RouteName.profile ? Colors.red : color),
        //   onPressed: () {
        //     Get.offNamed(RouteName.profile);
        //   },
        // ),
        // IconButton(
        //   icon: Obx(() =>
        //   controller.selectedImage.value.isNotEmpty
        //       ? Image.file(File(controller.selectedImage.value),width: screenWidth * 0.07,)
        //       : Image.asset(profile_icon, width: screenWidth * 0.07,)
        //   ),
        //   onPressed: () {
        //     Get.toNamed(RouteName.profile);
        //   },
        // ),
      ],
    ),
  );
}