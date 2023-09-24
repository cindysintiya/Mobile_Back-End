import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ContohStream extends StatefulWidget {
  const ContohStream({super.key});

  @override
  State<ContohStream> createState() => _ContohStreamState();
}

class _ContohStreamState extends State<ContohStream> {
  int percent = 100;
  int getStream = 0;
  double circular = 1;
  bool enabled = true;

  late StreamSubscription _sub;  // setiap data terbaca akan tersimpan di int getStream = 0
  final Stream _myStream = Stream.periodic(const Duration(seconds: 1), (int count) {
    return count;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Stream Demo"),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          final double avaWidth = constraints.maxWidth;
          final double avaHeight = constraints.maxHeight;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CircularPercentIndicator(
                  radius: avaHeight/5,
                  lineWidth: 10,
                  percent: circular,
                  center: Text("$percent %"),
                ),
              ),
              Text(percent == 100? "Full" : percent == 0? "Empty" : "", style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 150,),
            ],
          );
        }),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              _sub.cancel();
              setState(() {
                enabled = true;
                percent = 100;
                circular = 1;
              });
            }, 
            child: const Text("Reset"),
          ),
          if (enabled) FloatingActionButton(
            onPressed: () {
              _sub = _myStream.listen((event) {
                getStream = int.parse(event.toString());
                setState(() {
                  enabled = false;
                  if (percent - getStream <= 0) {
                    _sub.cancel();   // hentikan stream jk sdh mencapai 0
                    percent = 0;
                    circular = 0;
                  } else {   // jk blum capai 0, kurangi nilai percent sesuai nilai yg dikembalikan oleh sistem
                    percent -= getStream;
                    circular = percent/100;
                  }
                });
              }); // mendaftarkan stream yg dibuat
            }, 
            child: const Text("Start"),
          ),
          if (!enabled) FloatingActionButton(
            onPressed: () {
              _sub.resume();
            }, 
            child: const Text("Play"),
          ),
          if (!enabled) FloatingActionButton(
            onPressed: () {
              _sub.pause();
            }, 
            child: const Text("Stop"),
          ),
        ],
      ),
    );
  }
}