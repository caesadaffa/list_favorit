import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_favorit/home/HomeController.dart';
import 'package:list_favorit/widgets/navbar_bawah.dart';

import '../global/globalController.dart';

class HomePage extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Catalog'),
      ),
      body: Obx(() => controller.movieresponsemodel.isEmpty
          ? Center(
              child: CircularProgressIndicator()
            )
          : ListView.builder(
              itemCount: controller.movieresponsemodel[0].data.length,
              itemBuilder: (BuildContext context, int index) {
                final movies = controller.movieresponsemodel[0].data[index];
                print(movies);
                return Container(
                  child: ListTile(
                    leading: Image.network(
                      movies.poster,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(movies.title),
                    subtitle: Text('Director: ${movies.genre}'),
                    trailing: InkWell(
                      child: IconButton(
                        icon: Icon(
                          Icons.bookmark,
                          color: GlobalState.favoriteIds.contains(movies.id)
                              ? Colors.red
                              : null,
                        ),
                        onPressed: () {
                          controller.addFilm(movies);
                        },
                      ),
                    ),
                  ),
                );
              },
            )),
      bottomNavigationBar: NavbarBawah(pressedIcon: Colors.black),
    );
  }
}
