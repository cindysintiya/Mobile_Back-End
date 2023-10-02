class HistoryList {

  HistoryList(this.id, this.name, this.sum, this.harga, this.datetime);

  int id;
  String name;
  int sum;
  double harga;
  String datetime;

  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'name': name, 
      'sum': sum,
      'harga': harga,
      'datetime': datetime
    };  // utk tabel
  }

  @override
  String toString() {
    return "id: $id\nname: $name\nsum: $sum\nharga: $harga\ndatetime: $datetime";
  }
}