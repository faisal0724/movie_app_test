import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/movie_detail.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final String imdbID;
  DetailPage({required this.imdbID});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  MovieDetail? _moviesDetail;
  @override

  void initState(){
    super.initState();
    fetchDetail().then((value) =>
        setState(() {
          _moviesDetail = value;
        })
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Page"), backgroundColor: Colors.blueAccent,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text("${_moviesDetail?.title}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Image.network("${_moviesDetail?.poster}"),
              SizedBox(height: 8,),
              Text("Country : ${_moviesDetail?.country}"),
              SizedBox(height: 8,),
              Text("Runtime : ${_moviesDetail?.runtime}"),
              SizedBox(height: 8,),
              Text("imdbRating : ${_moviesDetail?.imdbRating}"),
            ],
          ),
        ),
      ),

    );
  }
  Future<MovieDetail> fetchDetail() async {
    final response = await http
        .get(Uri.parse('https://omdbapi.com/?i=${widget.imdbID}&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieDetail.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}