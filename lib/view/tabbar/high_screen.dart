import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/model/toDo.dart';
import 'package:hive_database/view/detailed_screen.dart';
import 'package:hive_flutter/adapters.dart';

import '../../widget/listtile_widget.dart';

class HighScreen extends StatefulWidget {
  final Box box;
  const HighScreen({Key? key, required this.box}) : super(key: key);

  @override
  State<HighScreen> createState() => _HighScreenState();
}

class _HighScreenState extends State<HighScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),

              /// completed
              ValueListenableBuilder(
                valueListenable: widget.box.listenable(),
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height / 1.5,
                      child: const Center(
                        child: Text("No data found"),
                      ),
                    );
                  } else if (value.isNotEmpty) {
                    return ListView.builder(
                      itemCount: value.values.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        ToDo toDo = value.getAt(index);

                        return toDo.category == "High" &&
                                toDo.isCompleted == false
                            ? ListTileWidget(
                                index: index,
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

              /// uncompleted
              ValueListenableBuilder(
                valueListenable: widget.box.listenable(),
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return Container();
                  } else if (value.isNotEmpty) {
                    return ListView.builder(
                      itemCount: value.values.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ToDo toDo = value.getAt(index);

                        return toDo.category == "High" &&
                                toDo.isCompleted == true
                            ? ListTileWidget(
                                toDo: toDo,
                                index: index,
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
            ],
          ),
        ),
      ),
    );
  }
}
