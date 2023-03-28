import 'package:hive/hive.dart';

/// this is generate person name adapter
part 'toDo.g.dart';

@HiveType(typeId: 0)
class ToDo {
  @HiveField(0)
  late final String title;
  @HiveField(1)
  late final String subTitle;
  @HiveField(2)
  late bool isCompleted;
  @HiveField(3)
  late final String category;
  @HiveField(4)
  late final DateTime dateTime;
}
