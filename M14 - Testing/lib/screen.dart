import 'package:case_study_latihan/exercise.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController textField = TextEditingController();
  int value = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App Testing"),),
      body: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text("COUNTER", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      value--;
                    });
                  },
                  child: const Text("Dec", key: Key("btnDec"),)
                ),
                Text(value.toString(), style: const TextStyle(fontSize: 25),),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      value++;
                    });
                  },
                  child: const Text("Inc", key: Key("btnInc"),)
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
              child: Text("REVERSE TEXT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            ),
            TextField(
              controller: textField,
              decoration: const InputDecoration(
                hintText: "Enter Text",
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    textField.text = String.fromCharCodes(
                      textField.text.runes.toList().reversed
                    );
                  });
                },
                child: const Text("Reverse", key: Key("btnReverse"),)
              ),
            ),


            // pindah page ke exercise
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => const TebakWarna())));
                },
                child: const Text("Exercise", key: Key("pindahExercise"),)
              ),
            )
          ],
        ),
      )
    );
  }
}