
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;

import 'ToDo.dart';

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

  Future<void> insertDB(TODO todo) async{
    Database db=await dbh.database;
    await db.insert('note_table', todo.toMap());
  }

  Future<void> UpdateDB(TODO todo)async{
    Database db=await dbh.database;
    await db.update('note_table', todo.toMap(), where: 'id=?', whereArgs: [todo.toMap()['id']]);
  }

  Future<void> deleteDB(TODO todo) async{
    Database db=await dbh.database;
    await db.delete('note_table', where: 'id=?', whereArgs: [todo.id]);
  }

  Future<List<TODO>> readDb() async{
    Database db = await dbh.database;
    final mp= await db.query('note_table');
    List<TODO>lst=[];

    mp.forEach((element) {
      lst.add(TODO(
        id: element['id'] as int,
        title: element['title'] as String,
        desc: element['desc'] as String
      ));
    });

    return lst;
  }
}