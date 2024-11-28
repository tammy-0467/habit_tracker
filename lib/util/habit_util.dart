//given a habit list of completion days is the habit completed today

import 'package:habittracker/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any(
      (date) =>
          date.year == today.year &&
          date.month == today.month &&
          date.day == today.day,
  );
}

//prepare heatmap dataset
Map<DateTime, int> prepHeatMapDataSet(List<Habit> habits){
  Map<DateTime, int> dataset = {};

  for (var habit in habits){
    for (var date in habit.completedDays){
      //normalize date to avoid time mismatch
      final normalizeDate = DateTime(date.year, date.month, date.day);

      //if the date already exists in the dataset increase the count
      if (dataset.containsKey(normalizeDate)){
        dataset[normalizeDate] = dataset[normalizeDate]! + 1;
      } else {
        // else intialize it with a count of 1
        dataset[normalizeDate] = 1;
      }
    }
  }
  return dataset;
}