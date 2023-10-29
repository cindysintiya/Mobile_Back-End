import 'dart:async';

import 'package:flutter/material.dart';
import 'package:case_study_latihan/challenge/http_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HttpHelper? helper;
  List? weathers;

  Map<String, String> category = {"temp": "Temperature", "humidity": "Humidity", "speed": "WindSpeed"};
  String kategori = "temp";

  Future initialize() async {
    helper?.jlh = 5;
    weathers = await helper?.getWeathers();
    setState(() {
      weathers = weathers;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  final ScrollController scroll = ScrollController();

  late Stream stream = Stream.periodic(const Duration(seconds: 5), (_) async {  // tiap 5 detik
    if (scroll.position.maxScrollExtent == scroll.offset) {   // check posisi scroll, klo mentok, br tambah data
      helper?.jlh += 5;
      weathers = await helper?.getWeathers();
    }
  });

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('${category[kategori]}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
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
              value: kategori,
              onChanged: (val) {
                setState(() {
                  kategori = val.toString();
                });
                initialize();
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: scroll,
              child: Column(
                children: [
                  StreamBuilder(
                    stream: stream,
                    builder: (context, snapshot) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(15, 3, 15, 14),
                        itemCount: (weathers?.length == null) ? 0 : weathers?.length,
                        itemBuilder: (BuildContext context, int position) {
                          return Card(
                            color: weathers![position].main.temp > 29? Colors.red[400] : Colors.green[400],
                            elevation: 2.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text((position+1).toString()),
                              ),
                              title: Text(weathers![position].name, style: const TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: kategori=="temp"? Text('Temperature: ${weathers![position].main.temp.toStringAsFixed(2)} °C'): kategori=="humidity"? Text('Humidity: ${weathers![position].main.humidity}') : Text('WindSpeed: ${weathers![position].wind.speed}'),
                            )
                          );
                        }
                      );
                    }
                  ),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}