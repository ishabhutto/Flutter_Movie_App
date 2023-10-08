import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_example/Text/text.dart';
import 'dart:convert';

import 'package:movie_app_example/Widgets/movie.dart';
import 'package:movie_app_example/Widgets/movie_details.dart';

class TV extends StatefulWidget {
  const TV({super.key});

  @override
  State<TV> createState() => TVState();
}

class TVState extends State<TV> {
  late Future<List<Movie>> movies;

  @override
  void initState() {
    super.initState();
    movies = fetchTvShowsMovies();
  }

  Future<List<Movie>> fetchTvShowsMovies() async {
    final apiKey = '7d9d211a409a411f66ca8ab92b898ad0';
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/movie/day?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      List<Movie> movies = results.map((json) => Movie.fromJson(json)).toList();

      return movies;
    } else {
      throw Exception('Failed to load movie data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Modified_Text(
              text: 'TV Shows',
              size: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold),
          const SizedBox(
            height: 20,
          ),
          Container(
              height: 400,
              child: FutureBuilder<List<Movie>>(
                future: movies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No movies found.');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
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
                            child: Container(
                              width: 140,
                              child: Column(children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(posterUrl)),
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  child: Modified_Text(
                                      text: movie.title,
                                      color: Colors.white,
                                      size: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ]),
                            ),
                          );
                        } else {
                          Container();
                        }
                      },
                    );
                  }
                },
              ))
        ]));
  }
}
