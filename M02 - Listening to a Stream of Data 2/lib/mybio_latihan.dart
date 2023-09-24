import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:case_study_latihan/mybio_provider.dart';

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
              Container(
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
                      // borderRadius: BorderRadius.circular(10)
                    ), 
                    width: 200, 
                    height: 200,
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.grey[800],
                    ),
                  )
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
                  step: 0.1,
                  decoration: const InputDecoration(labelText: "Decimals"),
                  onChanged: prov.setScore,
                ),
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