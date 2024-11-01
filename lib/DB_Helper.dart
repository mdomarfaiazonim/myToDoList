
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DB_Helper{
  static final DB_Helper dbh=DB_Helper._db_helper();
  DB_Helper._db_helper();

  static Database? _database;

  Future<Database>get database async{
    if(_database!=null){
      return _database!;
    }
    _database=await initDB();
    return _database!;
  }

  Future<Database> initDB() async{
    return await openDatabase(
      'notes.db',
      version: 1,
      onCreate: (db, version) async{
        await db.execute('''
          CREATE TABLE note_table(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            desc TEXT
          )
        ''');
      }
    );
  }

  Future<void> insertDB(Map<String,dynamic> row) async{
    Database db=await dbh.database;
    await db.insert('note_table', row);
  }

  Future<void> UpdateDB(Map<String,dynamic>row)async{
    Database db=await dbh.database;
    await db.update('note_table', row, where: 'id=?', whereArgs: [row['id']]);
  }

  Future<void> deleteDB(int id) async{
    Database db=await dbh.database;
    await db.delete('note_table', where: 'id=?', whereArgs: [id]);
  }

  Future<List<Map<String,dynamic>>> readDb() async{
    Database db = await dbh.database;
    return await db.query('note_table');
  }
}