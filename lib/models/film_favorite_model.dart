class FilmModel {
  int? id;
  String? title;
  String? genre;
  String? release;
  double? rate;
  int? duration;
  String? sinopsis;
  String? poster;

  FilmModel({this.id, this.title, this.genre, this.release, this.rate, this.duration, this.sinopsis, this.poster,});

  FilmModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    genre = json["genre"];
    release = json["release"];
    rate = json["rate"]?.toDouble();
    duration = json["duration"];
    sinopsis = json["sinopsis"];
    poster = json["poster"];
  }

  Map<String, dynamic> toJson() {
    return {
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
}