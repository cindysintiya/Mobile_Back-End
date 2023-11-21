import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:case_study_latihan/event_model.dart';
import 'package:case_study_latihan/home_exercise.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<EventModel> details = [];
  
  FirebaseFirestore db = FirebaseFirestore.instance;

  // get data
  Future readData() async {
    var data = await db.collection('event_detail').get();
    setState(() {
      details = data.docs.map((doc) => EventModel.fromDocSnapshot(doc)).toList();
    });
  }

  // insert data
  addRand() async {
    EventModel insertData = EventModel(
      judul: getRandString(5), 
      keterangan: getRandString(30), 
      tanggal: getRandString(10), 
      isLike: Random().nextBool(), 
      pembicara: getRandString(20)
    );
    await db.collection("event_detail").add(insertData.toMap());   // ubah data dr btk model EventModel menjadi map agar dpt dimasukkan ke cloud firestore
    setState(() {
      details.add(insertData);
      readData();  // krn data yg ditambah ke firestore bkn masuk ke data terakhir, tp diurutkan berdasarkan id random nya
    });
  }

  // buat string acak sbg inisialisasi nilai utk object
  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (index) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  // delete data
  deleteLast(String documentId) async {
    await db.collection("event_detail").doc(documentId).delete();
    setState(() {
      details.removeLast();
    });
  }

  // update data
  updateEvent(int pos) async {
    await db.collection('event_detail').doc(details[pos].id).update({'is_like' : !details[pos].isLike});
    setState(() {
      details[pos].isLike = !details[pos].isLike;
    });
  }

  @override
  void initState(){
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cloud Firestore"),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeExercise()));
            }, 
            icon: const Icon(Icons.swipe_right_rounded),
            label: const Text('Exercise'),
          ),
          const SizedBox(width: 10,)
        ],
      ),
      body: ListView.builder(
        itemCount: details.isNotEmpty? details.length : 0,
        itemBuilder: (context, position) {
          return CheckboxListTile(
            onChanged: (bool? value) {
              updateEvent(position);
            },
            value: details[position].isLike, 
            title: Text(details[position].judul, style: const TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("${details[position].keterangan} \nHari : ${details[position].tanggal} \nPembicara : ${details[position].pembicara}"),
            isThreeLine: true,
          );
        }
      ),
      floatingActionButton: FabCircularMenu(
        // https://stackoverflow.com/questions/76015716/the-getter-accentcolor-isnt-defined-for-the-class-themedata
        ringColor: Colors.pink[50],   // go to the fab_circular_menu.dart file, change the "accentColor" to "colorScheme.secondary"
        fabColor: Colors.pink[300],
        children: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Add data', 
            iconSize: 40,
            onPressed: () {
              addRand();
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove_rounded), 
            tooltip: 'Delete last data', 
            iconSize: 40,
            onPressed: () {
              if (details.last.id != null && details.last.id != "0000abcdefghijklmnop") {   // sisakan 1 data
                deleteLast(details.last.id!);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded), 
            tooltip: 'Refresh', 
            iconSize: 40,
            onPressed: () {
              readData();
            },
          ),
        ],
      ),
    );
  }
}