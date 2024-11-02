import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DBrepo.dart';
import 'provider_class.dart';
import 'ToDo.dart';

class ScreenPage extends StatelessWidget {
  ScreenPage({super.key});

  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final _lists = Provider.of<ProviderClass>(context).lists;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            children: [
              const Icon(Icons.menu, color: Colors.white),
              const SizedBox(width: 110),
              const Text('To Do List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          )
      ),
      body: Container(
        color: Colors.yellow[100],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: desc,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ProviderClass>(context, listen: false).addTODO(title.text, desc.text);
                title.clear();
                desc.clear();
              },
              child: const Text("Submit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.yellow),
              ),
            ),
            SizedBox(height: 20),

            Expanded(
              child: Consumer<ProviderClass>(
                builder: (context, provider, child) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(color: Colors.black,),
                    itemCount: provider.lists.length,
                    itemBuilder: (context, index) {
                      final todo = provider.lists[index];
                      return ListTile(
                        leading: Text(todo.id.toString(),style: TextStyle(fontSize: 15),),
                        title: Text(todo.title,style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(todo.desc),
                        trailing: IconButton(
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx){
                                    return AlertDialog(
                                      title: Text('What do you want to do ?'),
                                      actions: [

                                        TextButton(onPressed: (){
                                          Navigator.of(ctx).pop();
                                        }, child: Text("Cancel")),

                                        TextButton(
                                            onPressed: (){
                                              Provider.of<ProviderClass>(context, listen: false).delete(todo);
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text("Delete")
                                        ),

                                        TextButton(
                                            onPressed: (){
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext ct){
                                                    TextEditingController title2=TextEditingController();
                                                    TextEditingController desc2=TextEditingController();
                                                    title2.text=todo.title;
                                                    desc2.text=todo.desc;
                                                    return AlertDialog(
                                                      title: Text("Are you sure you want to update ?"),
                                                      actions: [
                                                        TextField(
                                                          controller: title2,
                                                          decoration: const InputDecoration(
                                                            hintText: 'Title',
                                                          ),
                                                        ),
                                                        TextField(
                                                          controller: desc2,
                                                          decoration: const InputDecoration(
                                                            hintText: 'Description',
                                                          ),
                                                        ),
                                                        TextButton(
                                                            onPressed: (){
                                                              // title2.text=todo.title;
                                                              // desc2.text=todo.desc;
                                                              Provider.of<ProviderClass>(context,listen: false).update(
                                                                TODO(id: todo.id, title: title2.text, desc: desc2.text)
                                                              );
                                                              title2.clear();
                                                              desc2.clear();
                                                              Navigator.of(ctx).pop();
                                                              Navigator.of(ct).pop();
                                                            },
                                                            child: Text("Update")),
                                                        TextButton(
                                                            onPressed: (){
                                                              Navigator.of(ct).pop();
                                                            },
                                                            child: Text("Cancel")
                                                        )
                                                      ],
                                                    );
                                                  }
                                              );
                                            },
                                            child: Text("Update")
                                        )
                                      ],
                                    );
                                  }
                              );
                            },
                            icon: Icon(Icons.edit)),
                        onTap: () {
                          title.text = todo.title;
                          desc.text = todo.desc;
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
