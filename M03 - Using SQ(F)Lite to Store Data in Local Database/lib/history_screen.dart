import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:case_study_latihan/my_provider.dart';
import 'package:case_study_latihan/db/dbhelper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  final DBHelper _dbHelper = DBHelper();
  
  @override
  void initState(){
    Future.microtask(() {
      Provider.of<ListProductProvider>(context, listen: false).loadData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ListProductProvider>(context, listen: true);  // listen true agar hasil di tampilkan/ refresh tiap perubahan
    _dbHelper.getHistoryList().then((value) => prov.historyList = value);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("History List"),
      ),
      body: ListView.builder(
        itemCount: prov.historyList.isNotEmpty? prov.historyList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          final data = prov.historyList[index];
          return ListTile(
            title: Text("${data.name} (\$ ${data.harga})", style: const TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text('Deleted on  ${DateFormat('hh/MM/yyyy  HH:mm').format(DateTime.parse(data.datetime))}'),
            leading: CircleAvatar(
              child: Text('#${data.id}'),
            ),
          );
        }
      ),
    );
  }

  // error while closing history page; still confusing
  // @override
  // void dispose() {
  //   _dbHelper.closeDb();
  //   super.dispose();
  // }
}