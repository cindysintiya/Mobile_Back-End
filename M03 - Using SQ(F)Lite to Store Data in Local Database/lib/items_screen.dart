import 'package:flutter/material.dart';
import 'package:case_study_latihan/shopping_list.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key, required this.shoppingList});

  final ShoppingList shoppingList;

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    final data = widget.shoppingList;

    return Scaffold(
      appBar: AppBar(
        title: Text("Data  #${data.id}"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(data.name[0], style: const TextStyle(fontSize: 40)),
            ),
            Text('Nama Item : ${data.name}', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            Text('Harga Satuan : \$ ${data.harga}', style: const TextStyle(fontSize: 20,)),
            Text('Jumlah : ${data.sum}', style: const TextStyle(fontSize: 20,)),
            Text('Total Harga : \$ ${(data.harga*data.sum).toStringAsFixed(2)}', style: const TextStyle(fontSize: 20,)),
          ],
        ),
      ),
    );
  }
}