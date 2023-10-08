import 'package:flutter/material.dart';
import 'package:movie_app_example/Text/heading.dart';
import 'package:movie_app_example/Widgets/favourites.dart';
import 'package:movie_app_example/Widgets/popular.dart';
import 'package:movie_app_example/Widgets/search.dart';
import 'package:movie_app_example/Widgets/toprated.dart';
import 'package:movie_app_example/Widgets/tvshows.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Modified_Text2(
            text: 'Movie App',
            color: Colors.red,
            size: 30.0,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyFvouritePage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 25.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchMovies(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.red,
                    size: 25.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        body: ListView(
          children: [
            TopRatedMovies(),
            TV(),
            PopularMovies(),
          ],
        ));
  }
}
