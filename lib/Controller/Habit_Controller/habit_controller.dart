
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker_app/Model/Habit_Model/habit_model.dart';

class HabitController extends GetxController {
  final habitController = TextEditingController();

  RxString selectedCategory = 'Other'.obs;
  RxString selectedFrequency = 'custom'.obs;

  final categories = ['Work', 'Health', 'Fitness', 'Study', 'Other'];

  Rx<DateTime> selectedDate = DateTime.now().obs;

  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;

  final formKey = GlobalKey<FormState>();
  RxList<Habit> habitList = <Habit>[].obs;

  final RxList<Color> colors = [
    Colors.yellow, Colors.orange, Colors.red, Colors.blue, Colors.green,
    Colors.teal, Colors.pink, Colors.purple, Colors.lightBlue, Colors.cyan,
  ].obs;

  final RxList<IconData> icons = [
    Icons.sports_soccer, Icons.wb_sunny, Icons.book, Icons.water_drop,
    Icons.restaurant, Icons.brightness_3, Icons.music_note, Icons.sports,
    Icons.flight, Icons.camera_alt, Icons.code, Icons.check,
    Icons.light_mode, Icons.nightlight, Icons.pets, Icons.cleaning_services,
  ].obs;

  RxBool showColors = true.obs;
  RxInt selectedColorIndex = 0.obs;
  RxInt selectedIconIndex = 0.obs;
  var tabVisible = false.obs;

  var startDateForComplete = DateTime.now().obs;
  var endDateForComplete = DateTime.now().add(Duration(days: 7)).obs;

  void updateDates(DateTime start, DateTime end) {
    startDate.value = start;
    endDate.value = end;
  }

  // Map<DateTime, List<String>> getHabitEvents() {
  //   Map<DateTime, List<String>> events = {};
  //
  //   DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);
  //
  //   for (var habit in habitList) {
  //     final start = normalize(habit.startDate!);
  //     final end = normalize(habit.endDate!);
  //
  //     if (habit.frequency == "custom") {
  //       for (DateTime d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
  //         events.putIfAbsent(normalize(d), () => []).add(habit.name);
  //       }
  //     }
  //
  //     else if (habit.frequency == "Weekly") {
  //       for (int i = 0; i < 7; i++) {
  //         final d = normalize(start.add(Duration(days: i)));
  //         if (d.isAfter(end)) break;
  //         events.putIfAbsent(d, () => []).add(habit.name);
  //       }
  //     }
  //
  //     else if (habit.frequency == "Monthly") {
  //       DateTime d = start;
  //       while (!d.isAfter(end)) {
  //         for (int i = 0; i < 30; i++) {
  //           final day = normalize(d.add(Duration(days: i)));
  //           if (day.isAfter(end)) break;
  //           events.putIfAbsent(day, () => []).add(habit.name);
  //         }
  //         d = DateTime(d.year, d.month + 1, d.day);
  //       }
  //     }
  //   }
  //
  //   return events;
  // }
  // 🔹 Single habit events
  Map<DateTime, List<String>> getHabitEvents(Habit habit) {
    final events = <DateTime, List<String>>{};
    DateTime normalize(DateTime d) => DateTime(d.year, d.month, d.day);

    final start = normalize(habit.startDate!);
    final end = normalize(habit.endDate!);

    if (habit.frequency == "custom") {
      for (DateTime d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
        events.putIfAbsent(d, () => []).add(habit.name ?? 'habit');
      }
    }  else if (habit.frequency == "Weekly") {
            for (int i = 0; i < 7; i++) {
              final d = normalize(start.add(Duration(days: i)));
              if (d.isAfter(end)) break;
              events.putIfAbsent(d, () => []).add(habit.name);
            }

    } else if (habit.frequency == "Monthly") {
      DateTime d = start;
      while (!d.isAfter(end)) {
        events.putIfAbsent(d, () => []).add(habit.name ?? 'habit');
        d = DateTime(d.year, d.month + 1, d.day);
      }
    }

    return events;
  }

// 🔹 All habits ni events (combine all)
  Map<DateTime, List<String>> getAllHabitEvents() {
    final allEvents = <DateTime, List<String>>{};
    for (var habit in habitList) {
      final habitEvents = getHabitEvents(habit);
      habitEvents.forEach((date, names) {
        allEvents.putIfAbsent(date, () => []).addAll(names);
      });
    }
    return allEvents;
  }


  Future<void> startDateMethod(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != startDate.value) {
      startDate.value = picked;
    }
  }

  Future<void> endDateMethod(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate.value,
      firstDate: startDate.value,
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != endDate.value) {
      endDate.value = picked;
    }
  }
}
