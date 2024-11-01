import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DBrepo.dart';
import 'ToDo.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {

  final DBrepo dbr=DBrepo();
  List<TODO> _lists=[];
  TextEditingController _title=TextEditingController();
  TextEditingController _desc=TextEditingController();


  void _load() async{
    final lists=await dbr.getlists();
    setState(() {
      _lists=lists;
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _addTODO() async{
    final Title=_title.text;
    final Desc=_desc.text;
    if(Title.isNotEmpty && Desc.isNotEmpty){
      final todo=TODO(
        title: Title,
        desc: Desc,
        id:_lists.length+1,
      );
      await dbr.insertDb(todo);
      _title.clear();
      _desc.clear();
      _load();
    }
  }

  void _delete(TODO todo) async{
    await dbr.deleteDb(todo);
    _load();
  }
  void _update(TODO todo) async{
    await dbr.UpdateDb(todo);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            children: [
              Icon(Icons.menu,color: Colors.white),
              SizedBox(width: 110),
              Text('To Do List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            ],
          )
      ),
      body: Container(
        color: Colors.yellow[100],
        child: Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _title,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _desc,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  _addTODO();
                },
                child:Text("Submit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black))
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context,index){
                    return Divider();
                  },
                  itemCount: _lists.length,
                  itemBuilder: (context,index){
                    final todo=_lists[index];
                    TextEditingController _title2=TextEditingController();
                    TextEditingController _desc2=TextEditingController();
                    return ListTile(
                      tileColor: Colors.yellow[800],
                      title: Text(todo.title,style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(todo.desc),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MaterialButton(
                              onPressed: (){
                            showDialog(
                                context: context,
                                builder: (BuildContext cc) {
                                  _title2.text=todo.title;
                                  _desc2.text=todo.desc;
                                  return AlertDialog(
                                    title: Text("Update or not"),
                                    content: Column(
                                      children: [

                                        TextField(
                                          controller: _title2,
                                          decoration: InputDecoration(
                                              hintText: 'title'
                                          ),
                                        ),
                                        TextField(
                                          controller: _desc2,
                                          decoration: InputDecoration(
                                              hintText: 'description'
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      MaterialButton(onPressed: (){
                                        Navigator.of(cc).pop();
                                      }, child: Text("Cancel")),
                                      MaterialButton(onPressed: (){
                                        setState(() {
                                          todo.title=_title2.text;
                                          todo.desc=_desc2.text;
                                        });
                                        _update(todo);
                                        Navigator.of(cc).pop();
                                      }, child: Text("Update"))
                                    ],
                                  );
                                },
                            );
                          }, child: Icon(Icons.edit,color: Colors.green,)),
                          MaterialButton(onPressed: (){
                            _delete(_lists[index]);
                          }, child: Icon(Icons.delete,color: Colors.red,)),
                        ],
                      )
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
