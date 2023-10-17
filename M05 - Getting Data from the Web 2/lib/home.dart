import 'package:flutter/material.dart';
import 'package:case_study_latihan/http_helper.dart';
import 'package:case_study_latihan/detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HttpHelper? helper;
  List? movies;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  // Map<String, String> category = {"latest": "Latest", "now_playing": "Now Playing", "popular": "Popular", "top_rated": "Top Rated", "upcoming": "Upcoming"};
  Map<String, String> category = {"now_playing": "Now Playing", "popular": "Popular", "top_rated": "Top Rated", "upcoming": "Upcoming"};

  TextEditingController searchBar = TextEditingController();
  String searchVal = '';

  Future initialize() async {
    movies = await helper?.getMovies();
    setState(() {
      movies = movies;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('${category[helper?.getCategory()]} Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      hintText: "Enter keyword(s) ...",
                      labelText: "Search title",
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: searchBar.text.isEmpty? const SizedBox() : IconButton(
                        onPressed: () {
                          setState(() {
                            searchBar.text = '';
                            searchVal = '';
                          });
                        }, 
                        icon: const Icon(Icons.close_rounded)
                      ),
                    ),
                    controller: searchBar,
                    onFieldSubmitted: (value) {
                      setState(() {
                        searchVal = value;
                      });
                    },
                  )
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  width: 150,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      labelText: 'Category',
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    items: category.keys.map((val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(category[val].toString())
                      );
                    }).toList(),
                    value: helper?.getCategory(),
                    onChanged: (val) {
                      helper?.changeCategory(val);
                      initialize();
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(15, 3, 15, 14),
              itemCount: (movies?.length == null) ? 0 : movies?.length,
              itemBuilder: (BuildContext context, int position) {
                if (movies![position].posterPath != null) {
                  image = NetworkImage(iconBase + movies![position].posterPath);
                } else {
                  image = NetworkImage(defaultImage);
                }
                return Visibility(
                  visible: movies![position].title.toString().toLowerCase().contains(searchVal.toLowerCase().trim()),
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: ListTile(
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(builder: (_) => DetailScreen(movies![position]));
                        Navigator.push(context, route);
                      },
                      leading: CircleAvatar(
                        backgroundImage: image,
                      ),
                      title: Text(movies![position].title, style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text('Released: ${movies![position].releaseDate}  -  Vote: ${movies![position].voteAverage}'),
                    )
                  ),
                );
              }
            ),
          ),
        ],
      )
    );
  }
}