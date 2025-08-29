import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker_app/Const/app_color.dart';
import 'package:habit_tracker_app/Controller/Habit_Controller/habit_controller.dart';
import 'package:habit_tracker_app/Screens/complate_habit.dart';
import 'package:habit_tracker_app/Screens/create_habit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HabitController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.lightPink,
      appBar: AppBar(
        backgroundColor: AppColors.lightPink,
        centerTitle: true,
        title: Text(
          "Habit Tracker",
          style: TextStyle(color: AppColors.darkPink),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.habitList.length,
          itemBuilder: (context, index) {
            print("Color :::::${controller.habitList[index].color}");
            return InkWell(
              onTap: () {
                Get.to(
                  CompleteHabit(
                    habit: controller.habitList[index],
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  leading: Icon(
                    IconData(
                      controller.habitList[index].icon,
                      fontFamily: controller.habitList[index].iconFontFamily,
                    ),
                    color: Color(controller.habitList[index].color),
                  ),

                  title: Text(controller.habitList[index].name.trim()),
                  subtitle: Text(
                    "Streak: ${controller.habitList[index].streak.toString()} days",
                  ),
                  trailing: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(controller.habitList[index].color),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.done, color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      // body:  GetBuilder<HabitController>(
      //   init: HabitController(),
      //   builder: (controller) {
      //     return  ListView.builder(
      //       itemCount: controller.habitList.length,
      //       itemBuilder: (context, index) {
      //         print("Color :::::${controller.habitList[index].color}");
      //         return InkWell(
      //           onTap: () {
      //             controller.update();
      //             Get.to(
      //               CompleteHabit(
      //                 habit: controller.habitList[index],
      //               ),
      //             );
      //           },
      //           child: Card(
      //             child: ListTile(
      //               leading: Icon(
      //                 IconData(
      //                   controller.habitList[index].icon,
      //                   fontFamily: controller.habitList[index].iconFontFamily,
      //                 ),
      //                 color: Color(controller.habitList[index].color),
      //               ),
      //
      //               title: Text(controller.habitList[index].name.trim()),
      //               subtitle: Text(
      //                 "Streak: ${controller.habitList[index].streak.toString()} days",
      //               ),
      //               trailing: Container(
      //                 height: 50,
      //                 width: 50,
      //                 decoration: BoxDecoration(
      //                   color: Color(controller.habitList[index].color),
      //                   borderRadius: BorderRadius.circular(5),
      //                 ),
      //                 child: Icon(Icons.done, color: Colors.white),
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      //
      // ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.darkPink,
        onPressed: () {
          Get.to(CreateHabit());
        },
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
