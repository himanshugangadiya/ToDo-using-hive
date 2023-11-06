import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_database/model/toDo.dart';
import 'package:intl/intl.dart';

import '../widget/toast_widget.dart';

class EditScreen extends StatefulWidget {
  final ToDo toDo;
  final int index;
  const EditScreen({Key? key, required this.toDo, required this.index})
      : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  String selectedPriority = "";
  late final Box<ToDo> box;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box<ToDo>("toDo");
    titleController = TextEditingController(text: widget.toDo.title);
    descriptionController = TextEditingController(text: widget.toDo.subTitle);
    selectedPriority = widget.toDo.category;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Title",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              // Text(widget.toDo.title),
              TextField(
                controller: titleController,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: descriptionController,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Priority",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RadioListTile(
                      value: "High",
                      contentPadding: EdgeInsets.zero,
                      title: const Text("High"),
                      groupValue: selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          selectedPriority = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RadioListTile(
                      value: "Medium",
                      contentPadding: EdgeInsets.zero,
                      title: const Text("Medium"),
                      groupValue: selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          selectedPriority = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RadioListTile(
                      value: "Low",
                      contentPadding: EdgeInsets.zero,
                      title: const Text("Low"),
                      groupValue: selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          selectedPriority = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Created Date & Time",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(DateFormat("dd/MM/yyyy  hh:mm a")
                  .format(widget.toDo.dateTime)),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    editToDo();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void editToDo() async {
    if (titleController.text.isNotEmpty) {
      ToDo toDo = ToDo()
        ..title = titleController.text
        ..subTitle = descriptionController.text
        ..category = selectedPriority
        ..isCompleted = widget.toDo.isCompleted
        ..dateTime = DateTime.now();

      try {
        await box.putAt(widget.index, toDo).then((value) {
          titleController.clear();
          descriptionController.clear();
          selectedPriority = "";
          Navigator.pop(context);
        });
      } catch (e) {
        log(e.toString());
      }
    } else {
      showToast(title: "Enter title to continue");
    }
  }
}
