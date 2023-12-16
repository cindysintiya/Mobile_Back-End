import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = "Stop Service";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Countdown Service"),),
      body: Center(
        child: StreamBuilder(
          stream: FlutterBackgroundService().on("update"), 
          builder: (context, snapshot) {            
            if (!snapshot.hasData) {
              return const Text("10 s", style: TextStyle(fontSize: 40),);
            }

            final data = snapshot.data;
            String? count = "${data?['count']} s";

            final service = FlutterBackgroundService();

            if (data?['count'] <= 0) {   // auto stop jk count sdh 0
              service.invoke("stopService");
              text = "Restart Service";
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(count, style: const TextStyle(fontSize: 40),),
                ElevatedButton(
                  onPressed: () async {
                    var isRunning = await service.isRunning();

                    if (isRunning) {
                      service.invoke("stopService");
                      text = "Restart Service";
                    } else {
                      service.startService();
                      text = "Stop Service";
                    }
                    setState(() { });
                  }, 
                  child: Text(text)
                )
              ],
            );
          }
        ),
      ),
    );
  }
}