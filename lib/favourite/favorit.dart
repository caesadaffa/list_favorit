import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_favorit/favourite/favoritController.dart';

import '../global/globalController.dart';
import '../models/film_favorite_model.dart';
import '../widgets/navbar_bawah.dart';

class FavoritePage extends StatelessWidget {
  FavoriteController controller = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: Obx(() => controller.refreshToggle.value
          ? RefreshIndicator(
        onRefresh: () async {
          await controller.getDataFilm();
          controller.refreshToggle.toggle();
        }, child: FutureBuilder<List<FilmModel>>(
          future: controller.getDataFilm(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                FilmModel movies = snapshot.data![index];
                return ListTile(
                  leading: Image.network(
                    movies.poster!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movies.title!),
                  subtitle: Text(movies.genre!),
                  trailing: InkWell(
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: GlobalState.favoriteIds.contains(movies.id!)
                            ? Colors.red
                            : null,
                      ),
                      onPressed: () {
                        controller.deleteFilm(movies.id!, movies.title!);
                      },
                    ),
                  ),
                );
              },
            );
          }
      ),
      )
         : FutureBuilder<List<FilmModel>>(
            future: controller.getDataFilm(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  FilmModel movies = snapshot.data![index];
                  return ListTile(
                    leading: Image.network(
                      movies.poster!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(movies.title!),
                    subtitle: Text(movies.genre!),
                    trailing: InkWell(
                      child: IconButton(
                        icon: Icon(
                          Icons.bookmark,
                          color: GlobalState.favoriteIds.contains(movies.id!)
                              ? Colors.red
                              : null,
                        ),
                        onPressed: () {
                          controller.deleteFilm(movies.id!, movies.title!);
                        },
                      ),
                    ),
                  );
                },
              );
            }
        ),),
      bottomNavigationBar: NavbarBawah(pressedIcon: Colors.black),
    );
  }
}