import 'package:sqflite/sqflite.dart';

import 'DB_Helper.dart';
import 'ToDo.dart';

class DBrepo{

  final DB_Helper db=DB_Helper.dbh;

  Future<void> insertDb(TODO todo) async{
    await db.insertDB(todo.toMap());
  }

  Future<void> deleteDb(TODO todo) async{
    await db.deleteDB(todo.id);
  }
  Future<void> UpdateDb(TODO todo) async{
    await db.UpdateDB(todo.toMap());
  }
  Future<List<TODO>> getlists() async{
    final List<Map<String,dynamic>> lists=await db.readDb();
    return List.generate(lists.length,(i)=>TODO(id: lists[i]['id'], title: lists[i]['title'], desc: lists[i]['desc']));
  }
}