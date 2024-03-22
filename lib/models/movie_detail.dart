// fetch data item 3a
//1 Create the class

//2 Create properties/variable of the class
class MovieDetail {
  final String title;
  final String year;
  final String runtime;
  final String country;
  final String metascore;
  final String imdbRating;
  final String poster;

  //3 Create the constructor
  MovieDetail({
    required this.title,
    required this.year,
    required this.runtime,
    required this.country,
    required this.metascore,
    required this.imdbRating,
    required this.poster,
  });

  //4 Create JSON to object transformer
  //after json["xxxx"], the xxxx must be same from api
  factory MovieDetail.fromJson(dynamic json) {
    return MovieDetail(
        title: json["Title"],
        year: json["Year"],
        runtime: json["Runtime"],
        country: json["Country"],
        metascore: json["Metascore"],
        imdbRating: json["imdbRating"],
        poster: json["Poster"]);
  }

  //5 if api have square bracket "[]", it is array. need to put static list
  // if only curly bracket "{}", it is object. no need to put static list below
}
