import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_example/Text/heading.dart';
import 'package:movie_app_example/Text/text.dart';
import 'dart:convert';
import 'package:movie_app_example/Widgets/movie.dart';
import 'package:movie_app_example/Widgets/movie_details.dart';

class SearchMovies extends StatefulWidget {
  const SearchMovies({super.key});

  @override
  State<SearchMovies> createState() => SearchMoviesState();
}

class SearchMoviesState extends State<SearchMovies> {
  TextEditingController searchController = TextEditingController();
  late Future<List<Movie>> search;
  @override
  void initState() {
    super.initState();
    search = fetchMovies();
  }

  Future<List<Movie>> fetchMovies() async {
    final apiKey = '7d9d211a409a411f66ca8ab92b898ad0';
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      List<Movie> movies = results.map((json) => Movie.fromJson(json)).toList();

      return movies;
    } else {
      throw Exception('Failed to load movie data');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final apiKey = '7d9d211a409a411f66ca8ab92b898ad0';
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      List<Movie> movies = results.map((json) => Movie.fromJson(json)).toList();

      return movies;
    } else {
      throw Exception('Failed to load movie data');
    }
  }

  void onSearch(String query) {
    setState(() {
      if (query.isNotEmpty) {
        search = searchMovies(query);
      } else {
        search = fetchMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Modified_Text2(
              text: 'Search Results',
              color: Colors.red,
              size: 30.0,
              fontWeight: FontWeight.bold),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF292B37),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 26,
                          ),
                          Container(
                            width: 300,
                            margin: EdgeInsets.only(left: 5),
                            child: TextField(
                              onChanged: onSearch,
                              controller: searchController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search movie here',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Modified_Text(
                      text: 'You may want to watch!',
                      size: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - -230,
                child: FutureBuilder<List<Movie>>(
                  future: search,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No movies found.');
                    } else {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemCount: min(6, snapshot.data!.length),
                        itemBuilder: (context, index) {
                          final movie = snapshot.data![index];
                          final posterPath = movie.posterPath;

                          if (posterPath != null && posterPath.isNotEmpty) {
                            final posterUrl =
                                'https://image.tmdb.org/t/p/w500$posterPath';

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetailsPage(movie: movie),
                                  ),
                                );
                              },
                              child: ListView(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 170,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(posterUrl),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 200,
                                        child: Modified_Text(
                                          text: movie.title,
                                          color: Colors.white,
                                          size: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
