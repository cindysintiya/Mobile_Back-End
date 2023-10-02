import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:case_study_latihan/shopping_list.dart';
import 'package:case_study_latihan/history_list.dart';

class DBHelper {
  Database? _database;
  final String _tableName = "shopping_list";
  final String _history = "history_list";
  final String _dbName = "shoppinglist_database.db";
  final int _dbVersion = 2;

  DBHelper() {
    _openDB();
  }

  Future<void> _openDB() async {
    // penghapusan database digunakan ketika sdh membuat database namun ternyata terjadi perubahan pd tabel 
    // await deleteDatabase(
    //   join(await getDatabasesPath(), _dbName)
    // );

    _database ??= await openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, name TEXT, sum INTEGER)");
        await db.execute("CREATE TABLE $_history (id INTEGER PRIMARY KEY, name TEXT, sum INTEGER, datetime TEXT)");
      }, 
      onUpgrade: (db, oldVersion, newVersion) async {
        if (_dbVersion > oldVersion) {
          await db.execute("ALTER TABLE $_tableName ADD harga FLOAT DEFAULT 0");
          await db.execute("ALTER TABLE $_history ADD harga FLOAT DEFAULT 0");
        }
      },
      version: _dbVersion
    );
  }

  Future<List<ShoppingList>> getShoppingList() async {
    if (_database != null) {
      final List<Map<String, dynamic>> maps = await _database!.query(_tableName);
      // print("Isi DB: $maps");
      return List.generate(maps.length, (i) {
        return ShoppingList(maps[i]['id'], maps[i]['name'], maps[i]['sum'], maps[i]['harga']);
      });
    }
    return [];
  }

  Future<List<HistoryList>> getHistoryList() async {
    if (_database != null) {
      List<Map<String, dynamic>> maps = await _database!.query(
        _history,
        orderBy: 'datetime DESC',  // urutkan berdasarkan waktu hapus, default id; DESC urutan tebalek
      );
      // print("Isi History: $maps");
      return List.generate(maps.length, (i) {
        return HistoryList(maps[i]['id'], maps[i]['name'], maps[i]['sum'], maps[i]['harga'], maps[i]['datetime']);
      });
    }
    return [];
  }

  Future<void> insertShoppingList(ShoppingList tmp) async {
    await _database?.insert(
      _tableName, 
      tmp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> insertHistoryList(ShoppingList tmp, DateTime dateTime) async {
    final data = tmp.toMap();
    await _database?.insert(
      _history, 
      {
        'id': data['id'],
        'name': data['name'],
        'sum': data['sum'],
        'harga': data['harga'],
        'datetime': dateTime.toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> deleteShoppingList(int id) async {
    await _database?.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<void> deleteAll() async {
    await _database?.delete(
      _tableName,
    );
  }

  Future<void> closeDb() async {
    await _database?.close();
  }
}