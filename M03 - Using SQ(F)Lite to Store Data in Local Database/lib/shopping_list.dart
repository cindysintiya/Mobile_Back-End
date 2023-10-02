class ShoppingList {

  ShoppingList(this.id, this.name, this.sum, this.harga);

  int id;
  String name;
  int sum;
  double harga;

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'sum': sum, 'harga': harga};  // utk tabel
  }

  @override
  String toString() {
    return "id: $id\nname: $name\nsum: $sum\nharga: $harga";
  }
}