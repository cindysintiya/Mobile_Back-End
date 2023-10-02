import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:case_study_latihan/my_provider.dart';
import 'package:case_study_latihan/items_screen.dart';
import 'package:case_study_latihan/shopping_list.dart';
import 'package:case_study_latihan/shopping_list_dialog.dart';
import 'package:case_study_latihan/history_screen.dart';
import 'package:case_study_latihan/db/dbhelper.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {

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
    _dbHelper.getShoppingList().then((value) => prov.shoppingList = value);
    _dbHelper.getHistoryList().then((value) => prov.historyList = value);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen()));
            }, 
            icon: const Icon(Icons.history_rounded),
            tooltip: "History",
          ),
          IconButton(
            onPressed: () {
              if (prov.shoppingList.isNotEmpty) {
                final data = prov.shoppingList;
                for (var i = 0; i < data.length; i++) {
                  _dbHelper.insertHistoryList(data[i], DateTime.now());
                }
                _dbHelper.deleteAll();
                prov.deleteAll();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All data deleted")));
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nothing to delete")));
              }
            }, 
            icon: const Icon(Icons.delete_rounded),
            tooltip: "Delete All",
          ),
          const SizedBox(width: 10,)
        ],
      ),
      body: ListView.builder(
        itemCount: prov.shoppingList.isNotEmpty? prov.shoppingList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(prov.shoppingList[index].id.toString()), 
            onDismissed: (direction) {
              String tmpName = prov.shoppingList[index].name;
              int tmpId = prov.shoppingList[index].id;
              _dbHelper.insertHistoryList(prov.shoppingList[index], DateTime.now());
              prov.deleteById(prov.shoppingList[index]);
              _dbHelper.deleteShoppingList(tmpId);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$tmpName deleted")));
            },
            child: ListTile(
              title: Text(prov.shoppingList[index].name.toString()),
              subtitle: Text("\$ ${prov.shoppingList[index].harga}"),
              leading: CircleAvatar(
                child: Text("#${prov.shoppingList[index].id}"),
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return ShoppingListDialog(_dbHelper).buildDialog(context, prov.shoppingList[index], false);
                    }
                  );

                  // hubungkan provider dgn database jd tiap ada perubahan data, provider bs lgsg tampilkan ke screen
                  _dbHelper.getShoppingList().then((value) => prov.shoppingList = value);
                }, 
                icon: const Icon(Icons.edit_rounded)
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => ItemsScreen(shoppingList: prov.shoppingList[index],))));
              },
            )
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context, 
            builder: (context) {
              return ShoppingListDialog(_dbHelper).buildDialog(context, ShoppingList(prov.id+1, "", 0, 0), true);
            }
          );
          _dbHelper.getShoppingList().then((value) => prov.shoppingList = value);
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  @override
  void dispose() {
    _dbHelper.closeDb();
    super.dispose();
  }
}