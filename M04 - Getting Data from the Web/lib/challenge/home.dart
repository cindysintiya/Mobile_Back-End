import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:case_study_latihan/challenge/http_helper.dart';

class MyHomeChallenge extends StatefulWidget {
  const MyHomeChallenge({super.key});

  @override
  State<MyHomeChallenge> createState() => _MyHomeChallengeState();
}

class _MyHomeChallengeState extends State<MyHomeChallenge> {

  late double result;
  late HttpHelper helper;

  Map<String, String> kota = {"medan": "Medan", "jakarta": "Jakarta", "samarinda": "Samarinda", "palangkaraya": "Palangkaraya", "bali": "Bali"};


  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    result = 0;
  }

  @override
  Widget build(BuildContext context) {
    helper.getWeather().then((value) {
      setState(() {
        result = value-273;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cuaca Medan"),
        actions: [
          Text('Tgl: ${DateFormat("dd/MM/yyy").format(DateTime.now())}', style: const TextStyle(fontSize: 18),),
          const SizedBox(width: 15,)
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                labelText: 'Category',
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              items: kota.keys.map((val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(kota[val].toString())
                );
              }).toList(),
              value: helper.getKota(),
              onChanged: (val) {
                helper.changeKota(val);
              },
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: result < 29? Colors.green : Colors.red,
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${result.toStringAsFixed(2)} °C', style: const TextStyle(fontSize: 30),),
                  Text(result < 29? "Dingin cuyy" : "Panas cuyy")
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}