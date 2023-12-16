import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:case_study_latihan/screen.dart';

void backgroundCompute(args) {
  print("background compute callback");
  print("calculating fibonacci from a background process");

  int first = 0;
  int second = 1;

  for (var i = 2; i <= 50; i++) {
    var temp = second;
    second = first + second;
    first = temp;
    sleep(const Duration(milliseconds: 200));
    print("first: $first; second: $second");
  }
  print("finished calculating fibo");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  runApp(const MyApp());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "foreground",
    "Foreground Service",
    description: "This channel is used for important notifications",
    importance: Importance.low
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground
    ), 
    androidConfiguration: AndroidConfiguration(
      onStart: onStart, // fungsi yang akan dijalankan ketika service dijalankan
      autoStart: false,  // apakah service ini nantinya berjalan secara otomatis ketika aplikasi dijalankan
      isForegroundMode: true, // apakah service ini dapat berjalan di atas aplikasi, dan lain sebagainya
      notificationChannelId: "foreground",
      initialNotificationTitle: "Foreground Service",
      initialNotificationContent: "Initializing",
      foregroundServiceNotificationId: 880
    )
  );
  
  service.startService();
}

@pragma("vm:entry-point")
Future<bool> onIosBackground(ServiceInstance service) async {
  return true;
}

void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  int sum = 10;  // biar gk kelamaan; aslinya 60s :v
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    sum--;
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(880, "Countdown Service", "Remaining $sum times ...", const NotificationDetails(
          android: AndroidNotificationDetails(
            "foreground", 
            "Foreground Service",
            icon: "ic_bg_service_small",
            ongoing: true
          )
        ));
      }
    }

    print("Background Service : $sum");

    service.invoke("update", {"count" : sum});
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final home = Scaffold(
      appBar: AppBar(title: const Text("Cindy Sintiya")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            compute(backgroundCompute, null);
          }, 
          child: const Text("Calculate fibo on compute isolate")
        ),
      ),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: home
      home: const HomeScreen()
    );
  }
}
