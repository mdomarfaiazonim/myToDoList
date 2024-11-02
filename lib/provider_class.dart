import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_list_withdatabase/DB_Helper.dart';

import 'DBrepo.dart';
import 'ToDo.dart';

class ProviderClass extends ChangeNotifier{

  final DB_Helper dbhelp=DB_Helper.dbh;

  List<TODO> _lists=[];

  List<TODO> get lists=>_lists;

  ProviderClass(){
    load();
  }

  void load() async{
    _lists=await dbhelp.readDb();
    notifyListeners();
  }
  void addTODO(String Title,String Desc) async{

    if(Title.isNotEmpty && Desc.isNotEmpty){
      final todo=TODO(
        title: Title,
        desc: Desc,
        id:_lists.length+1,
      );
      await dbhelp.insertDB(todo);
      load();
      notifyListeners();
    }
  }
  void delete(TODO todo) async{
    await dbhelp.deleteDB(todo);
    load();
    notifyListeners();
  }
  void update(TODO todo) async{
    await dbhelp.UpdateDB(todo);
    load();
    notifyListeners();
  }

}