import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_db/contact.dart';

class DBHelper {
  static Future<Database> initDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'pagol.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    final sql =
        ''' CREATE TABLE student( id INTEGER PRIMARY KEY, name TEXT,contact TEXT) ''';

    await db.execute(sql);
  }

  static Future<int> createContacts(Contact contact) async {
    Database db = await DBHelper.initDB();
    return await db.insert('student', contact.toJson());
  }

  static Future<List<Contact>> readContacts() async {
    Database db = await DBHelper.initDB();
    var contact = await db.query('student', orderBy: 'name');

    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((details) => Contact.fromJson(details)).toList()
        : [];
    return contactList;
  }
}
