
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker_app/Model/Habit_Model/habit_model.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Const/app_color.dart';
import '../Controller/Habit_Controller/habit_controller.dart';

class CompleteHabit extends StatelessWidget {
  final Habit habit;
  CompleteHabit({super.key,required this.habit});

  final controller = Get.find<HabitController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPink,
      appBar: AppBar(
        backgroundColor: AppColors.lightPink,
        title: Text("Habit Calendar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final habitEvents = controller.getHabitEvents(habit);
          return TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: controller.selectedDate.value,
            selectedDayPredicate: (day) =>
                isSameDay(controller.selectedDate.value, day),
            onDaySelected: (selectedDay, focusedDay) {
              controller.selectedDate.value = selectedDay;
            },
            eventLoader: (day) {
              final d = DateTime(day.year, day.month, day.day); // normalize
              return habitEvents[d] ?? [];
            },
            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                color: AppColors.darkPink,
                shape: BoxShape.circle,
              ),
            ),
          );

        }),
      ),
    );
  }
}
