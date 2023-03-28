import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/toDo.dart';

class ListTileWidget extends StatefulWidget {
  ToDo toDo;

  final VoidCallback onTapDelete;
  final VoidCallback onTap;
  final VoidCallback onTapEdit;
  final void Function(bool?) onChangeComplete;

  ListTileWidget({
    Key? key,
    required this.toDo,
    required this.onTapDelete,
    required this.onChangeComplete,
    required this.onTap,
    required this.onTapEdit,
  }) : super(key: key);

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  String value = "Edit";
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      title: Text(widget.toDo.title),
      subtitle: Text(widget.toDo.subTitle),
      leading: Checkbox(
        value: widget.toDo.isCompleted,
        onChanged: widget.onChangeComplete,
      ),
      trailing: PopupMenuButton(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        position: PopupMenuPosition.over,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: widget.onTapEdit,
              value: "Edit",
              child: const Text("Edit"),
              // height: 80,
            ),
            PopupMenuItem(
              onTap: widget.onTapDelete,
              value: "Delete",
              child: const Text("Delete"),
            ),
          ];
        },
        onSelected: (String newValue) {
          setState(() {
            value = newValue;
            debugPrint("debugPrint=============$value");
            print("print=============$value");
          });
        },
      ),
    );
  }
}
