//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:habit_tracker_app/Model/Habit_Model/habit_model.dart';
// import 'package:habit_tracker_app/Services/Db_Services/db_services.dart';
// import 'package:table_calendar/table_calendar.dart';
// import '../Const/app_color.dart';
// import '../Controller/Habit_Controller/habit_controller.dart';
//
// class CompleteHabit extends StatelessWidget {
//   final Habit habit;
//   CompleteHabit({super.key, required this.habit});
//
//   final controller = Get.find<HabitController>();
//
//   bool hasEventMethod(DateTime date) {
//     final start = DateTime(habit.startDate!.year, habit.startDate!.month, habit.startDate!.day);
//     print("start ::: $start");
//     final d = DateTime(date.year, date.month, date.day);
//     print("d $d");
//     final diff = d.difference(start).inDays;
//     print("difffffffffff:::$diff");
//
//     if (controller.selectedFrequency.value == "custom") {
//       final end = DateTime(habit.endDate!.year, habit.endDate!.month, habit.endDate!.day);
//       print(" return diff >= 0 && d.compareTo(end) <= 0; ${diff >= 0 && d.compareTo(end) <= 0}");
//       return diff >= 0 && d.compareTo(end) <= 0;
//     } else if (controller.selectedFrequency.value == "Weekly") {
//       print("Weekly ${diff >= 0 && diff < 7}");
//       return diff >= 0 && diff < 7;
//     } else if (controller.selectedFrequency.value == "Monthly") {
//       print("Monthly ${diff >= 0 && diff < 30}");
//
//       return diff >= 0 && diff < 30;
//     }
//     return false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightPink,
//       appBar: AppBar(
//         backgroundColor: AppColors.lightPink,
//         title: Text("Habit Calendar"),
//       ),
//       body: GetBuilder<HabitController>(
//         builder: (controllerG) {
//          return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child:  TableCalendar(
//                     firstDay: DateTime.utc(2000, 1, 1),
//                     lastDay: DateTime.utc(2100, 12, 31),
//                     focusedDay: controllerG.selectedDate.value,
//                     selectedDayPredicate: (day) => isSameDay(controllerG.selectedDate.value, day),
//                     onDaySelected: (selectedDay, focusedDay) {
//                       controllerG.selectedDate.value = selectedDay;
//                       controllerG.update();
//                     },
//                     calendarBuilders: CalendarBuilders(
//                       markerBuilder: (context, date, events) {
//                         if (hasEventMethod(date)) {
//                           return Positioned(
//                             bottom: 1,
//                             child: Container(
//                               height: 6,
//                               width: 6,
//                               decoration: BoxDecoration(
//                                 color: AppColors.darkPink,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                           );
//                         }
//                         return null;
//                       },
//                     ),
//                     calendarStyle: CalendarStyle(
//                       markerDecoration: BoxDecoration(
//                         color: AppColors.darkPink,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//
//               ),
//               Expanded(
//                 child: hasEventMethod(controllerG.selectedDate.value)
//                     ? ListTile(
//                   title: Text(habit.name),
//                   subtitle: Text("Streak :${habit.streak}"),
//                   leading: Icon(IconData(habit.icon,fontFamily: habit.iconFontFamily,),color: Color(habit.color),),
//                   trailing: InkWell(
//                     onTap: () async {
//                       final now = DateTime.now();
//                       final today = DateTime(now.year, now.month, now.day);
//                       final selected = DateTime(
//                         controllerG.selectedDate.value.year,
//                         controllerG.selectedDate.value.month,
//                         controllerG.selectedDate.value.day,
//                       );
//                       if(selected==today){
//                         String date = controllerG.selectedDate.value.toIso8601String().split("T")[0];
//                         await HabitDB.habitCompletion(habit.id ?? 0, date,0);
//                         controllerG.update();
//                       }else{
//                         Get.snackbar("Info", "You can only complete today’s habit");
//                       }
//                     },
//                     child: Obx(() {
//                       String date = controllerG.selectedDate.value.toIso8601String().split("T")[0];
//                       return FutureBuilder(
//                         future: HabitDB.isHabitCompleted(habit.id ?? 0, date),
//                         builder: (context, snapshot) {
//                           final now = DateTime.now();
//                           final today = DateTime(now.year, now.month, now.day);
//                           final selected = DateTime(
//                             controllerG.selectedDate.value.year,
//                             controllerG.selectedDate.value.month,
//                             controllerG.selectedDate.value.day,
//                           );
//                           bool done = snapshot.data ?? false;
//                           return Container(
//                             height: 30,
//                             width: 30,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all()
//                             ),
//                             child: (selected==today && done) ? Icon(Icons.done,color: Color(habit.color),) : null,
//                           );
//                         },
//                       );
//                     }),
//                   ),
//                 )
//                     : const Center(child: Text("No habit on this date")),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker_app/Model/Habit_Model/habit_model.dart';
import 'package:habit_tracker_app/Services/Db_Services/db_services.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Const/app_color.dart';
import '../Controller/Habit_Controller/habit_controller.dart';

class CompleteHabit extends StatelessWidget {
  final Habit habit;
  CompleteHabit({super.key, required this.habit});

  final controller = Get.find<HabitController>();

  bool hasEventMethod(DateTime date) {
    final start = DateTime(habit.startDate!.year, habit.startDate!.month, habit.startDate!.day);
    final d = DateTime(date.year, date.month, date.day);
    final diff = d.difference(start).inDays;

    if (controller.selectedFrequency.value == "custom") {
      final end = DateTime(habit.endDate!.year, habit.endDate!.month, habit.endDate!.day);
      return diff >= 0 && d.compareTo(end) <= 0;
    } else if (controller.selectedFrequency.value == "Weekly") {
      return diff >= 0 && diff < 7;
    } else if (controller.selectedFrequency.value == "Monthly") {
      return diff >= 0 && diff < 30;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPink,
      appBar: AppBar(
        backgroundColor: AppColors.lightPink,
        title: const Text("Habit Calendar"),
      ),
      body: GetBuilder<HabitController>(
        builder: (controllerG) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: controllerG.selectedDate.value,
                  selectedDayPredicate: (day) => isSameDay(controllerG.selectedDate.value, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    controllerG.selectedDate.value = selectedDay;
                    controllerG.update();
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (hasEventMethod(date)) {
                        return Positioned(
                          bottom: 1,
                          child: Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                              color: AppColors.darkPink,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                  calendarStyle: CalendarStyle(
                    markerDecoration: BoxDecoration(
                      color: AppColors.darkPink,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: hasEventMethod(controllerG.selectedDate.value)
                    ? ListTile(
                  title: Text(habit.name),
                  subtitle: Text("Streak : ${habit.streak}"),
                  leading: Icon(
                    IconData(habit.icon, fontFamily: habit.iconFontFamily),
                    color: Color(habit.color),
                  ),
                  trailing: InkWell(
                    onTap: () async {
                      String date = controllerG.selectedDate.value.toIso8601String().split("T")[0];

                        await HabitDB.habitCompletion(habit.id ?? 0, date, 0);
                        controllerG.update();

                    },
                    child: Obx(() {
                      String date = controllerG.selectedDate.value.toIso8601String().split("T")[0];
                      return FutureBuilder(
                        future: HabitDB.isHabitCompleted(habit.id ?? 0, date,),
                        builder: (context, snapshot) {
                          bool done = snapshot.data ?? false;
                          return Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(),
                            ),
                            child: done
                                ? Icon(Icons.done, color: Color(habit.color))
                                : null,
                          );
                        },
                      );
                    }),
                  ),
                )
                    : const Center(child: Text("No habit on this date")),
              )
            ],
          );
        },
      ),
    );
  }
}
