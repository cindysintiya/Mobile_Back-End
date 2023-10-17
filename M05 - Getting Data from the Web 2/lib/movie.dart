class Movie {
  final int id;
  final String title;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final String overview;
  final String posterPath;

  Movie(this.id, this.title, this.popularity, this.voteAverage, this.voteCount, this.releaseDate, this.overview, this.posterPath);

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    final id = parsedJson['id'] as int;
    final title = parsedJson['title'] as String;
    final popularity = parsedJson['popularity'] as double;
    final voteAverage = parsedJson['vote_average'] * 1.0 as double;
    final voteCount = parsedJson['vote_count'] as int;
    final releaseDate = parsedJson['release_date'] as String;
    final overview = parsedJson['overview'] as String;
    final posterPath = parsedJson['poster_path'] as String;

    return Movie(id, title, popularity, voteAverage, voteCount, releaseDate, overview, posterPath);
  }
}