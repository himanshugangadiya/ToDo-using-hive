import 'package:flutter/material.dart';
import 'package:hive_database/view/home_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'model/toDo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final document = await getApplicationDocumentsDirectory();

  /// initialize hive
  await Hive.initFlutter(document.path);

  // Registering the adapter
  Hive.registerAdapter(ToDoAdapter());

  /// open box
  await Hive.openBox<ToDo>("toDo");
  await Hive.openBox("test");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
