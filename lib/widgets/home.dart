import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app_test/models/movie_detail.dart';
import 'package:movie_app_test/models/movie_search.dart';
import 'package:movie_app_test/widgets/detail.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var searchEditingController = TextEditingController();
  var _movies = [
    // {
    //   "Title": "Harry Potter and the Sorcerer's Stone",
    //   "Year": "2001",
    //   "imdbID": "tt0241527",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BNmQ0ODBhMjUtNDRhOC00MGQzLTk5MTAtZDliODg5NmU5MjZhXkEyXkFqcGdeQXVyNDUyOTg3Njg@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Chamber of Secrets",
    //   "Year": "2002",
    //   "imdbID": "tt0295297",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMjE0YjUzNDUtMjc5OS00MTU3LTgxMmUtODhkOThkMzdjNWI4XkEyXkFqcGdeQXVyMTA3MzQ4MTc0._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Prisoner of Azkaban",
    //   "Year": "2004",
    //   "imdbID": "tt0304141",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMTY4NTIwODg0N15BMl5BanBnXkFtZTcwOTc0MjEzMw@@._V1_SX300.jpg"
    // },
    // {
    //   "Title": "Harry Potter and the Goblet of Fire",
    //   "Year": "2005",
    //   "imdbID": "tt0330373",
    //   "Type": "movie",
    //   "Poster":
    //       "https://m.media-amazon.com/images/M/MV5BMTI1NDMyMjExOF5BMl5BanBnXkFtZTcwOTc4MjQzMQ@@._V1_SX300.jpg"
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movie App",
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(hintText: "Enter the movie name"),
                  controller: searchEditingController,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: ElevatedButton(
                      onPressed: () {
                        // sama mcm
                        // var movies = await fetchMovies() ;
                        fetchMovies(searchEditingController.text)
                            .then((value) => {
                                  setState(() {
                                    _movies = value;
                                    //the red at value because have mock data.
                                    // so, need to remove mock data.
                                    // at the same time change listTile
                                  })
                                });
                      },
                      child: Text("Search Movies")))
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text("${_movies[index].title}"),
                      subtitle: Text("${_movies[index].year}"),
                      leading: _movies[index].poster == "N/A"
                          ? SizedBox()
                          : Image.network("${_movies[index].poster}"),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      imdbID: "${_movies[index].imdbID}",
                                    )));
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  //future is an asynchronous method (backrground call).
  // must have async await or .then
  // <> -> the return data type.
  // {} => ClassName , [] => List<ClassName>
  Future<List<MovieSearch>> fetchMovies(String search) async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?s=$search&apikey=87d10179'));
    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //jsonDecode -> import dart:convert
      return MovieSearch.moviesFromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
  // Future<MovieDetail> fetchDetail() async {
  //   final response = await http
  //       .get(Uri.parse('https://omdbapi.com/?i=tt1669165&apikey=87d10179'));
  //
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return MovieDetail.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }
}
