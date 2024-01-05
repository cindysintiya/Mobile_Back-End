import 'package:flutter/material.dart';

class TebakWarna extends StatefulWidget {
  const TebakWarna({super.key});

  @override
  State<TebakWarna> createState() => _TebakWarnaState();
}

class _TebakWarnaState extends State<TebakWarna> {
  final List colors = ["Merah", "Kuning", "Hijau", "Biru"];
  String answer = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tebak Warna")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/soal_merah.png", width: 200,),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("Apa warna gambar diatas?"),
            ),
            Wrap(
              children: colors.map((color) {
                return RadioListTile(
                  value: color, 
                  title: Text(color),
                  groupValue: answer, 
                  onChanged: (val) {
                    setState(() {
                      answer = val;
                    });
                    showDialog(
                      context: context, 
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Konfirmasi pengiriman jawaban"),
                          content: Text('Apakah kamu yakin dengan pilihan "$answer" dan akan mengirimkan jawaban kamu ke server?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HasilJawaban(kondisiJawaban: answer=="Merah")));
                              }, 
                              child: const Text("Kirim")
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, 
                              child: const Text("Cek kembali")
                            )
                          ],
                        );
                      }
                    );
                  }
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}




class HasilJawaban extends StatelessWidget {
  const HasilJawaban({super.key, required this.kondisiJawaban}); 
  final bool kondisiJawaban;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hasil")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              kondisiJawaban? Icons.check_circle_rounded : Icons.cancel_rounded, 
              size: 150,
              color: kondisiJawaban? Colors.green : Colors.red,
            ),
            const SizedBox(height: 30,),
            Text(kondisiJawaban? "Jawaban Kamu Benar" : "Jawaban Kamu Salah", style: const TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}