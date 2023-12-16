import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Semantic")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Semantics(
              label: "Judul Aplikasi",  // cocok untuk widget text
              child: const Text("Aplikasi Semantics buatan Anak Negeri")
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Isikan Nama",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.help_rounded,
                    semanticLabel: "Bantuan",   // cocok utk listtile sekaligus, bkn dibaca per item dlm listtile
                  ),
                  title: const Text("Hubungi", style: TextStyle(color: Colors.blue),),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.help_rounded,
                    semanticLabel: "email",
                  ),
                  title: const Text("cindy@sintiya.com", style: TextStyle(color: Colors.blue),),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: MergeSemantics(  // cocok utk widget yg salign berhubungan
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked, 
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    }
                  ),
                  Semantics(
                    hint: _isChecked? "Anda memilih untuk Setuju" : "Anda belum Setuju",   // cocok utk checkbox
                    child: const Text("Setuju")
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: Semantics(
                      onTapHint: "Ketuk 2 kali untuk masuk ke aplikasi",  // cocok utk tekan tombol, bkn hanya baca text tombol, tp jg hint tambahan yg kt set
                      child: const Text("Masuk")
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: Semantics(
                      onTapHint: "Ketuk 2 kali untuk keluar aplikasi",
                      child: const Text("Keluar")
                    )
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}