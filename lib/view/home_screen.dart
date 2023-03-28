import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/model/toDo.dart';
import 'package:hive_database/view/tabbar/high_screen.dart';
import 'package:hive_database/view/tabbar/low_screen.dart';
import 'package:hive_database/view/tabbar/medium_screen.dart';
import 'package:hive_flutter/adapters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Box<ToDo> box;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedPriority = "High";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Get reference to an already opened box
    box = Hive.box<ToDo>("toDo");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const SliverAppBar(
                  pinned: true,
                  floating: true,
                  centerTitle: true,
                  title: Text(
                    "To Do",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.black,
                    indicatorPadding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    tabs: [
                      Tab(
                        text: "High",
                      ),
                      Tab(
                        text: "Medium",
                      ),
                      Tab(
                        text: "Low",
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                HighScreen(
                  box: box,
                ),
                MediumScreen(box: box),
                LowScreen(box: box),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        title: const Text("Add Info"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Radio<String>(
                                  value: "High",
                                  groupValue: selectedPriority,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPriority = value!;
                                    });
                                  },
                                ),
                                const Text("High"),
                                Radio<String>(
                                  value: "Medium",
                                  groupValue: selectedPriority,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPriority = value!;
                                    });
                                  },
                                ),
                                const Text("Medium"),
                                Radio<String>(
                                  value: "Low",
                                  groupValue: selectedPriority,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPriority = value!;
                                    });
                                  },
                                ),
                                const Text("Low"),
                              ],
                            ),
                            TextField(
                              controller: titleController,
                              decoration: const InputDecoration(
                                label: Text("Enter title"),
                              ),
                            ),
                            TextField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                label: Text("Enter description"),
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: Colors.blue,
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    ToDo toDo = ToDo()
                                      ..title = titleController.text
                                      ..subTitle = descriptionController.text
                                      ..isCompleted = false
                                      ..category = selectedPriority
                                      ..dateTime = DateTime.now();

                                    box.add(toDo);
                                    Navigator.pop(context);
                                    titleController.clear();
                                    descriptionController.clear();
                                  },
                                  color: Colors.blue,
                                  child: const Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
