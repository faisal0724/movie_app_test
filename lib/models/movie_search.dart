// fetch data item 3a
//1 Create the class

class MovieSearch {
  //2 Create properties/variable of the class
  final String title;
  final String year;
  final String imdbID;
  final String type;
  final String poster;

  //3 Create the constructor
  MovieSearch({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.type,
    required this.poster,
  });

  //4 Create JSON to object transformer
  //after json["xxxx"], the xxxx must be same from api
  factory MovieSearch.fromJson(dynamic json) {
    return MovieSearch(
      title: json["Title"],
      year: json["Year"],
      imdbID: json["imdbID"],
      type: json["Type"],
      poster: json["Poster"],
    );
  }

  //5 if api have square bracket "[]", it is array. need to put static list
  // if only curly bracket "{}", it is object. no need to put static list below
  static List<MovieSearch> moviesFromJson(dynamic json ){
    var searchResult = json["Search"]; //the word search depend on what written from api
    // create empty list of Movie Search
    List<MovieSearch> results = List.empty(growable: true);

    if (searchResult != null){
      // if not blank, go through the json for each json object
      searchResult.forEach((v)=>{
        results.add(MovieSearch.fromJson(v))
      });
      return results;
    }
    return results;
  }
}
