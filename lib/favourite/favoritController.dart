import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/film_favorite_model.dart';
import '../global/globalController.dart';

class FavoriteController extends GetxController {
  RxBool refreshToggle = false.obs;
  Database? database;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  Future<List<FilmModel>> getDataFilm() async {
    String table = "film";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_film";
    database = await openDatabase(path);
    final data = await database!.query(table);
    List<FilmModel> film = data.map((e) => FilmModel.fromJson(e)).toList();
    return film;
  }

  Future<void> deleteFilm(int id, String name) async {
    String table = "film";
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "db_film";
    database = await openDatabase(path);
    await database!.delete(table, where: "id = ?", whereArgs: [id]);
    GlobalState.favoriteIds.remove(id);
    showSnackBar('Film $name removed from favorites');
    refreshToggle.toggle();
  }
}

void showSnackBar(String message) {
  Get.snackbar(
    'Favorite Films',
    message,
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: 1),
    colorText: Colors.black,
  );
}