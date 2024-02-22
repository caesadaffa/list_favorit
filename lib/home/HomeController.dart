import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/film_favorite_model.dart';
import '../../models/film_model.dart';
import '../global/globalController.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList <MovieResponseModel> movieresponsemodel = <MovieResponseModel>[].obs;
  Database? database;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProduct();
    initDatabase();
  }

  Future<void> fetchProduct() async {
    try {
      final response = await http.get(
        Uri.parse("https://movieonetake.000webhostapp.com/movie/json"),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        movieresponsemodel.value = [movieResponseModelFromJson(response.body)];
        isLoading = false.obs;
        print(isLoading.value);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  void initDatabase() async {
    String db_name = "db_film";
    int db_version = 1;
    String table = "film";
    String id = "id";
    String title = "title";
    String genre = "genre";
    String release = "release";
    String rate = "rate";
    String duration = "duration";
    String sinopsis = "sinopsis";
    String poster = "poster";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + db_name;

    if (database == null) {
      database = await openDatabase(path, version: db_version,
          onCreate: (db, version) {
            print(path);
            db.execute('''          
CREATE TABLE IF NOT EXISTS $table (
  $id INTEGER PRIMARY KEY AUTOINCREMENT,
  $title VARCHAR(255), 
  $genre VARCHAR(255),
  $release VARCHAR(255),
  $rate INTEGER,
  $duration INTEGER,
  $sinopsis VARCHAR(255),
  $poster VARCHAR(255)
)''');
          });
      print(database);
    }
  }

  void addFilm(Datum movie) async {
    String table = "film";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_film";
    database = await openDatabase(path);

    FilmModel filmModel = FilmModel(
      id: movie.id,
      poster: movie.poster,
      title: movie.title,
      release: movie.release,
      genre: movie.genre,
      duration: movie.duration,
      rate: movie.rate,
    );

    var result = await database!.query(table, where: 'id = ?', whereArgs: [movie.id]);

    if (result.isEmpty) {
      await database!.insert(table, filmModel.toJson());
      GlobalState.favoriteIds.add(movie.id);
      showSnackBar('Favorite Films', 'Film ${movie.title} added to favorites');
    } else {
      await database!.delete(table, where: "id = ?", whereArgs: [movie.id]);
      GlobalState.favoriteIds.remove(movie.id);
      showSnackBar('Favorite Films', 'Film ${movie.title} removed from favorites');
    }

    fetchProduct();
  }
}

void showSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: 1),
    colorText: Colors.black,
  );
}