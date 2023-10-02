import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:case_study_latihan/challenge/mybio_provider.dart';

class MyBio extends StatefulWidget {
  const MyBio({super.key});

  @override
  State<MyBio> createState() => _MyBioState();
}

class _MyBioState extends State<MyBio> {

  @override
  void initState(){
    super.initState();
    Future.microtask(() {
      Provider.of<MyBioProvider>(context, listen: false).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<MyBioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bio Exercise"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              StreamBuilder(
                stream: prov.streamCtrl.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.none) {
                      return const Padding(
                        padding: EdgeInsets.fromLTRB(8, 90, 8, 90),
                        child: Text("Fetching data ..."),
                      );
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.fromLTRB(8, 90, 8, 90),
                        child: Text("We almost got it. Please wait ..."),
                      );
                    } else if (snapshot.connectionState == ConnectionState.active) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(50, 98, 50, 98),
                        child: LinearProgressIndicator(
                          value: snapshot.data! / prov.score,
                        ),
                      );
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(color: Colors.red[200]),
                        child: prov.image != null
                        ? Image.file(
                            File(prov.image!), 
                            width: 100, 
                            height: 100, 
                            fit: BoxFit.fitHeight,
                          )
                        : Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 198, 198, 198),
                            ), 
                            width: 200, 
                            height: 200,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.grey[800],
                            ),
                          )
                      );
                    }
                  } else {
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(8, 90, 8, 90),
                      child: Text("Waiting user to press button ..."),
                    );
                  }
                  return Container();
                }
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    XFile? image = await prov.picker.pickImage(source: ImageSource.gallery);
                    prov.setImage(image?.path);
                  },
                  child: const Text("Take Image"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SpinBox(
                  max: 10.0,
                  min: 0.0,
                  value: prov.score,
                  decimals: 1,
                  step: 1,
                  decoration: const InputDecoration(labelText: "Timer"),
                  onChanged: prov.setScore,
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: prov.score == 0? null : () async {
                      // await Future.delayed(Duration(seconds: prov.score.toInt()));
                      // prov.streamCtrl.add(1);
                      prov.streamCtrl = StreamController<int>();
                      prov.setScore(prov.score);
                      int timer = 0;
                      while (timer <= prov.score.toInt() + 1) {
                        await Future.delayed(const Duration(seconds: 1));
                        prov.streamCtrl.add(timer);
                        timer++;
                      }
                      prov.streamCtrl.close();
                    },
                    child: const Text("Stream Future"),
                  ),
                  ElevatedButton(
                    onPressed: prov.score == 0? null : () {
                      prov.streamCtrl = StreamController<int>();
                      prov.setScore(prov.score);
                      int timer = 0;
                      Timer.periodic(const Duration(seconds: 1), (count) {
                        prov.streamCtrl.add(timer);
                        timer++;
                        if (timer > prov.score.toInt() + 1) {
                          prov.streamCtrl.close();
                          count.cancel();
                        }
                      });
                    },
                    child: const Text("Stream Timer"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: InputDatePickerFormField(
                        initialDate: DateTime.parse(prov.date),
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2250),
                        onDateSubmitted: (date) {
                          prov.setDate(date.toString());
                        },
                      )
                    ),
                    IconButton(
                      onPressed: () async {
                        var res = await showDatePicker(
                          context: context, 
                          initialDate: DateTime.parse(prov.date), 
                          firstDate: DateTime(2000), 
                          lastDate: DateTime(2500)
                        );
                        if (res != null) {
                          prov.setDate(res.toString());
                        }
                      }, 
                      icon: const Icon(Icons.date_range_rounded)
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}