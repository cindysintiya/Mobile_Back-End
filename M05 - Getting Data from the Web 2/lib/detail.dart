import 'package:flutter/material.dart';
import 'package:case_study_latihan/movie.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';
  const DetailScreen(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String path;

    if (movie.posterPath.isNotEmpty) {
      path = imgPath + movie.posterPath;
    } else {
      path = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              height: height / 1.5,
              child: Image.network(path)
            ),
            const Text("Overview", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(movie.overview, textAlign: TextAlign.justify,)
            ),
            const Divider(indent: 16, endIndent: 16, height: 30,),
            // const Text("Detail", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            Text('Popularity : ${movie.popularity}'),
            Text('Vote : ${movie.voteAverage}'),
            Text('Total vote : ${movie.voteCount}'),
            const SizedBox(height: 16,)
          ],
        )
      )
      )
    );
  }
}