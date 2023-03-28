import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../model/toDo.dart';
import '../../widget/listtile_widget.dart';
import '../detailed_screen.dart';

class LowScreen extends StatefulWidget {
  final Box box;

  const LowScreen({Key? key, required this.box}) : super(key: key);

  @override
  State<LowScreen> createState() => _LowScreenState();
}

class _LowScreenState extends State<LowScreen> {
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
                  ToDo toDo = value.getAt(index);

                  return toDo.category == "Low"
                      ? ListTileWidget(
                          toDo: toDo,
                          onTapDelete: () {
                            widget.box.deleteAt(index);
                          },
                          onChangeComplete: (value) async {
                            setState(() {
                              toDo.isCompleted = value!;
                              widget.box.putAt(index, toDo);
                              log("======================= ${toDo.isCompleted}");
                            });
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
