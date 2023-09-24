import 'package:flutter/material.dart';

class ContohFuture extends StatefulWidget {
  const ContohFuture({super.key});

  @override
  State<ContohFuture> createState() => _ContohFutureState();
}

class _ContohFutureState extends State<ContohFuture> {
  var data = [];
  var data2 = [];

  Future<List<String>> getUserData() async {  // pakai Future agar durasi delayed >5 detik tdk menimbulkan ANR Android not responding
    var data = ["Bunny", "Funny", "Miles"];  // tdk bagus pake setstate didlm future lgsg, krn gbs dipanggil klo dr file lain

    await Future.delayed(const Duration(seconds: 3), () {
      print("Downloaded ${data.length} data");
    });
    return data;
  }

  Future<List<Map>> getFullData() async {  // pakai Future agar durasi delayed >5 detik tdk menimbulkan ANR Android not responding
    var data2 = [
      {'nama': 'Bunny', 'noHp': '123456'},
      {'nama': 'Funny', 'noHp': '098765'},
      {'nama': 'Miles', 'noHp': '975313'},
    ];

    await Future.delayed(const Duration(seconds: 3), () {
      print("Downloaded ${data.length} data");
    });
    return data2;
  }

  void getData() async {
    var ambil = await getUserData();
    setState(() {
      data = ambil;
    });
  }

  void getData2() async {
    var ambil = await getFullData();
    setState(() {
      data2 = ambil;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Future Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Daftar Pengguna", style: Theme.of(context).textTheme.titleLarge,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('$data'),
            ),
            ElevatedButton(
              onPressed: ()  {
                // getUserData();
                getData();
                print("Getting user data ...");
              },
              child: const Text("Get User")
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: data2.length * 70,
                child: ListView(
                  children: data2.map((val) {
                    // return Text("${val['nama']} : ${val['noHp']}");
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(val['nama'][0]),
                      ),
                      title: Text(val['nama'], style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(val['noHp']),
                    );
                  }).toList(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: ()  {
                getData2();
                print("Getting full data ...");
              },
              child: const Text("Get Full Data")
            ),
          ]
        ),
      ),
    );
  }
}