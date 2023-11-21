import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:case_study_latihan/event_model.dart';
import 'package:case_study_latihan/home.dart';

class HomeExercise extends StatefulWidget {
  const HomeExercise({super.key});

  @override
  State<HomeExercise> createState() => _HomeExerciseState();
}

class _HomeExerciseState extends State<HomeExercise> {
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
  addEvent(String judul, String keterangan, String tanggal, String pembicara) async {
    EventModel insertData = EventModel(
      judul: judul, 
      keterangan: keterangan, 
      tanggal: tanggal, 
      isLike: false, 
      pembicara: pembicara
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

  // delete data
  deleteEvent(String documentId) async {
    await db.collection("event_detail").doc(documentId).delete();
    setState(() {
      details.removeWhere((data) => data.id == documentId);
    });
  }

  // update data
  updateLike(int pos) async {
    await db.collection('event_detail').doc(details[pos].id).update({'is_like' : !details[pos].isLike});
    setState(() {
      details[pos].isLike = !details[pos].isLike;
    });
  }
  updateEvent(int pos, String judul, String keterangan, String tanggal, String pembicara) async {
    await db.collection('event_detail').doc(details[pos].id).update({
      'judul' : judul,
      'keterangan' : keterangan,
      'tanggal' : tanggal,
      'pembicara' : pembicara,
    });
    setState(() {
      details[pos].judul = judul;
      details[pos].keterangan = keterangan;
      details[pos].tanggal = tanggal;
      details[pos].pembicara = pembicara;
    });
  }

  openAlert(String title, {int position = -1}) {
    showDialog(
      context: context, 
      builder: (context) {
        TextEditingController judul = TextEditingController();
        TextEditingController keterangan = TextEditingController();
        TextEditingController tanggal = TextEditingController();
        TextEditingController pembicara = TextEditingController();
        if (position != -1) {
          judul.text = details[position].judul;
          keterangan.text = details[position].keterangan;
          tanggal.text = details[position].tanggal;
          pembicara.text = details[position].pembicara;
        }
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: judul,
                  decoration: const InputDecoration(
                    labelText: "Judul",
                    hintText: "Judul",
                  ),
                ),
                TextField(
                  controller: keterangan,
                  decoration: const InputDecoration(
                    labelText: "Keterangan",
                    hintText: "Keterangan"
                  ),
                  minLines: 1,
                  maxLines: 2,
                ),
                TextField(
                  controller: tanggal,
                  decoration: const InputDecoration(
                    labelText: "Tanggal",
                    hintText: "Hari, tgl bln thn"
                  ),
                ),
                TextField(
                  controller: pembicara,
                  decoration: const InputDecoration(
                    labelText: "Pembicara",
                    hintText: "Pembicara"
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Map data = {
                  'judul' : judul.text.trim(),
                  'keterangan' : keterangan.text.trim(),
                  'tanggal' : tanggal.text.trim(),
                  'pembicara' : pembicara.text.trim(),
                };
                if (data.values.contains("")) {
                  for (var key in data.keys) {
                    if (data[key] == "") {   // replace data yg kosong dgn random string
                      data[key] = getRandString(10);
                    }
                  }
                } 
                if (position == -1) {
                  addEvent(data['judul'], data['keterangan'], data['tanggal'], data['pembicara']);
                } else {
                  updateEvent(position, data['judul'], data['keterangan'], data['tanggal'], data['pembicara']);
                }
                Navigator.pop(context);
              }, 
              child: Text(position == -1? 'Tambahkan' : 'Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('Batal'),
            )
          ],
        );
      }
    );
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
        title: const Text('Exercise ver.'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHome()));
            }, 
            icon: const Icon(Icons.swipe_left_rounded),
            label: const Text('Home'),
          ),
          const SizedBox(width: 10,)
        ],
      ),
      body: ListView.builder(
        itemCount: details.isNotEmpty? details.length : 0,
        itemBuilder: (context, position) {
          return ListTile(
            title: Text(details[position].judul, style: const TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("${details[position].keterangan} \nHari : ${details[position].tanggal} \nPembicara : ${details[position].pembicara}"),
            isThreeLine: true,
            trailing: IconButton(
              onPressed: () {
                updateLike(position);
              },
              tooltip: details[position].isLike? 'Unlike' : 'Like',
              icon: Icon(Icons.favorite_rounded, size: 30, color: details[position].isLike? Colors.red : Colors.grey,),
            ),
            onTap: () {
              if (details[position].id == '0000abcdefghijklmnop') {
                ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(
                  const SnackBar(
                    content: Text('Acara ini tidak dapat diedit!'),
                  )
                );
              } else {
                openAlert('Edit Event ${details[position].judul}', position: position);
              }
            },
            onLongPress: () {
              if (details[position].id == '0000abcdefghijklmnop') {
                ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(
                  const SnackBar(
                    content: Text('Acara ini tidak dapat dihapus!'),
                    // behavior: SnackBarBehavior.floating,
                  )
                );
              } else {
                showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Hapus Acara "${details[position].judul}?"', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      content: const Text('Anda akan menghapus ini. Konfirmasi?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            deleteEvent(details[position].id!);
                            Navigator.pop(context);
                          }, 
                          child: const Text('Hapus'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                          child: const Text('Batal'),
                        )
                      ]
                    );
                  }
                );
              }
            },
          );
        }
      ),
      floatingActionButton: FabCircularMenu(
        // https://stackoverflow.com/questions/76015716/the-getter-accentcolor-isnt-defined-for-the-class-themedata
        ringColor: Colors.pink[50],   // go to the fab_circular_menu.dart file, change the "accentColor" to "colorScheme.secondary"
        fabColor: Colors.pink[300],
        children: [
          IconButton(
            icon: const Icon(Icons.post_add_rounded),
            tooltip: 'Add data', 
            iconSize: 40,
            onPressed: () {
              openAlert('Tambah Event Baru');
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Add RANDOM data', 
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