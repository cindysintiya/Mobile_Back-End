import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:case_study_latihan/my_provider.dart';
import 'package:case_study_latihan/shopping_list.dart';
import 'package:case_study_latihan/db/dbhelper.dart';

class ShoppingListDialog {
  final DBHelper _dbHelper;
  ShoppingListDialog(this._dbHelper);

  final txtName = TextEditingController();
  final txtSum = TextEditingController();
  final txtHarga = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew) {
    var prov = Provider.of<ListProductProvider>(context, listen: false);   
    // listen hrs false biar bs tiap ketik dia gk cek ulang yg if isNew

    if (!isNew) {
      txtName.text = list.name;
      txtSum.text = list.sum.toString();
      txtHarga.text = list.harga.toString();
    } else {
      txtName.text = "";
      txtSum.text = "";
      txtHarga.text = "";
    }

    return AlertDialog(
      title: Text(isNew? "New Shopping List #${list.id}" : "Edit Shopping List #${list.id}"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: 'Shopping List Name'),
            ),
            TextField(
              controller: txtSum,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: 'Jumlah Barang'),
            ),
            TextField(
              controller: txtHarga,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Harga Satuan'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: ElevatedButton(
                onPressed: () {
                  list.name = txtName.text.isNotEmpty? txtName.text : "Empty #${list.id}";  // hrsnya "Empty" doank, tp biar nampak beda
                  list.sum = txtSum.text.isNotEmpty? int.parse(txtSum.text) : 0;
                  list.harga = txtHarga.text.isNotEmpty? double.parse(txtHarga.text) : 0;
                  _dbHelper.insertShoppingList(list);
                  Navigator.pop(context);
                  if (isNew) prov.setId(list.id);
                }, 
                child: const Text("Save Shopping List")
              ),
            ),
          ],
        ),
      ),
    );
  }
}