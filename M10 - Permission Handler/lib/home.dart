import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:case_study_latihan/camera.dart';
import 'package:case_study_latihan/contact.dart';
import 'package:case_study_latihan/location.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

  void contact() async {
    if (await Permission.contacts.status.isGranted) {
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactScreen()));        
      }
    } else {
      var status = await Permission.contacts.request();
      print(status);
      if (status == PermissionStatus.granted && mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactScreen()));
      } else if (status == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
  }

  void camera() async {
    if (await Permission.camera.status.isGranted) {
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraScreen()));
      }
    } else {
      var status = await Permission.camera.request();
      print(status);
      if (status == PermissionStatus.granted && mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraScreen()));
      } else if (status == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
  }

  void location() async {
    if (await Permission.location.serviceStatus.isEnabled) {   // cek lokasi sdh aktif/ belum
      var status = await Permission.location.request();
      print(status);
      if (status == PermissionStatus.granted && mounted) {   // cek izin akses sdh diberikan/ belum
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationScreen()));
      } else if (trial <= 3) {   // 3 kali kesempatan utk ulang
        showPermissionAlert2("Konfirmasi Ulang izin akses LOKASI", "Kami membutuhkan izin akses LOKASI untuk menampilkan detail lokasi Anda saat ini. Silahkan izinkan penggunaan lokasi.", location, await Permission.location.status.isGranted);
      } else if (status == PermissionStatus.permanentlyDenied || trial > 3) {
        // diatas 3 kali atau lgsg di tolak, paksa buka utk izinkan
        openAppSettings();
      }
    } else {   // lokasi tdk aktif
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nyalakan LOKASI-mu!")));
      }
    }
  }

  void showPermissionAlert(String title, String message, Function permission) async {
    var i = 0;
    while (i < 3) {
      await showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () async {
                  bool result = false;
                  await permission().then((value) => result = value);
                  i++;
                  if (mounted && result) {
                    i = 3;
                  } else if (mounted) {
                    Navigator.pop(context);
                  }
                }, 
                child: const Text("Izinkan")
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  i++;
                }, 
                child: const Text("Tolak")
              )
            ],
          );
        }
      );
    }
  }
  
  var trial = 1;    
  void showPermissionAlert2(String title, String message, Function permission, bool status) {
    if (status) {
      permission();
    } else {
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);   // close alert dulu
                  trial++;  // kesempatan ++
                  permission();   // buka dialog permission
                }, 
                child: const Text("Izinkan")
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  trial++;
                  if (trial <= 3) {
                    // tolak belum 3x, rekursif
                    showPermissionAlert2("Konfirmasi Ulang izin akses LOKASI", message, permission, status);
                  } else {
                    openAppSettings();   // tolak lebih dr 3x, paksa
                  }
                }, 
                child: const Text("Tolak")
              )
            ],
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: contact, 
              child: const Text("Contact")
            ),
            ElevatedButton(
              onPressed: camera, 
              child: const Text("Camera")
            ),
            ElevatedButton(
              onPressed: () async {
                trial = 1;
                if (mounted) {
                  showPermissionAlert2("Izin akses Lokasi", "Kami membutuhkan izin akses LOKASI untuk menampilkan detail lokasi Anda saat ini. Silahkan izinkan penggunaan lokasi.", location, await Permission.location.status.isGranted);                  
                }
              }, 
              child: const Text("Location")
            ),
          ],
        ),
      ),
    );
  }
}