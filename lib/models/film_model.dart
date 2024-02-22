// To parse this JSON data, do
//
//     final movieResponseModel = movieResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MovieResponseModel movieResponseModelFromJson(String str) => MovieResponseModel.fromJson(json.decode(str));

String movieResponseModelToJson(MovieResponseModel data) => json.encode(data.toJson());

class MovieResponseModel {
  bool success;
  String message;
  List<Datum> data;

  MovieResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) => MovieResponseModel(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String title;
  String genre;
  String release;
  double rate;
  int duration;
  String sinopsis;
  String poster;

  Datum({
    required this.id,
    required this.title,
    required this.genre,
    required this.release,
    required this.rate,
    required this.duration,
    required this.sinopsis,
    required this.poster,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    genre: json["genre"],
    release: json["release"],
    rate: json["rate"]?.toDouble(),
    duration: json["duration"],
    sinopsis: json["sinopsis"],
    poster: json["poster"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "genre": genre,
    "release": release,
    "rate": rate,
    "duration": duration,
    "sinopsis": sinopsis,
    "poster": poster,
  };
}