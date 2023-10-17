
import 'package:flutter/material.dart';
import 'package:case_study_latihan/http_helper.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  late String result;
  late HttpHelper helper;
  Map<String, String> category = {"latest": "Latest", "now_playing": "Now Playing", "popular": "Popular", "top_rated": "Top Rated", "upcoming": "Upcoming"};

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    result = "";
  }

  @override
  Widget build(BuildContext context) {
    helper.getMovie().then((value) {
      setState(() {
        result = value;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Movie"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: DropdownButton(
                // decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(5),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: category.keys.map((val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(category[val].toString())
                  );
                }).toList(),
                value: helper.getCategory(),
                onChanged: (val) {
                  helper.changeCategory(val);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(result.toString()),
            )
          ],
        ),
      ),
    );
  }
}
