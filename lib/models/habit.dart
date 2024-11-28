import 'package:isar/isar.dart';

// run cmd to generate file: dart run build_runner build

part 'habit.g.dart';

@collection
class Habit {

  //Habit ID
  Id id = Isar.autoIncrement;

  //Habit Name
  late String name;

  //Completed days
  List<DateTime> completedDays = [
    //DateTime (Year, month, day)
  ];
}