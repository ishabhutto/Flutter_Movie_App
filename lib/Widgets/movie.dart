class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? banner;
  final double vote; // Change the type to double
  final String? launch_on;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.banner,
    required this.vote,
    required this.launch_on,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      banner: json['backdrop_path'] ?? '',
      vote: (json['vote_average'] ?? 0).toDouble(), // Convert to double
      launch_on: json['release_date'] ?? '',
    );
  }
}
