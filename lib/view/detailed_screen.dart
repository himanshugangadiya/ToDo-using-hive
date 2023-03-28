import 'package:flutter/material.dart';
import 'package:hive_database/model/toDo.dart';

class DetailedScreen extends StatefulWidget {
  final ToDo toDo;
  const DetailedScreen({Key? key, required this.toDo}) : super(key: key);

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
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
              Text(widget.toDo.title),
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
              Text(widget.toDo.subTitle),
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
              Text(widget.toDo.category),
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
              Text(widget.toDo.dateTime.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
