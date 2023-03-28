import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/widget/listtile_widget.dart';
import 'package:hive_flutter/adapters.dart';

import '../../model/toDo.dart';
import '../detailed_screen.dart';

class MediumScreen extends StatefulWidget {
  final Box box;

  const MediumScreen({Key? key, required this.box}) : super(key: key);

  @override
  State<MediumScreen> createState() => _MediumScreenState();
}

class _MediumScreenState extends State<MediumScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: widget.box.listenable(),
          builder: (context, value, child) {
            if (value.isEmpty) {
              return const Center(
                child: Text("No data found"),
              );
            } else if (value.isNotEmpty) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  ToDo? toDo = value.getAt(index);

                  return toDo!.category == "Medium"
                      ? ListTileWidget(
                          toDo: toDo,
                          onTapDelete: () {
                            widget.box.deleteAt(index);
                          },
                          onChangeComplete: (value) {
                            setState(() {
                              toDo.isCompleted = value!;
                            });
                            widget.box.putAt(index, toDo);
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailedScreen(toDo: toDo),
                              ),
                            );
                          },
                          onTapEdit: () {},
                        )
                      : Container();
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
