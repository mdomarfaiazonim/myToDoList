import 'package:flutter/material.dart';
import 'package:flutter_todo_list_withdatabase/DB_Helper.dart';
import 'package:flutter_todo_list_withdatabase/DBrepo.dart';
import 'provider_class.dart';
import 'ScreenPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderClass()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenPage(),
      ),
    );
  }
}