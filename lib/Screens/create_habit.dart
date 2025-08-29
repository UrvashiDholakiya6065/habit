
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker_app/Const/app_color.dart';
import 'package:habit_tracker_app/Controller/Habit_Controller/habit_controller.dart';
import 'package:habit_tracker_app/Model/Habit_Model/habit_model.dart';
import 'package:intl/intl.dart';

import '../Services/Db_Services/db_services.dart';

class CreateHabit extends StatelessWidget {
  final controller = Get.find<HabitController>();

  CreateHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPink,
      appBar: AppBar(
        title: const Text("Create Habit"),
        actions: [
          InkWell(
            onTap: () async {
              if (controller.formKey.currentState!.validate()) {
                final selectedIcon = controller.icons[controller.selectedIconIndex.value];
                final selectedColor = controller.colors[controller.selectedColorIndex.value];
              final inserHabit= Habit(
                    name: controller.habitController.text,
                    icon: selectedIcon.codePoint,
                    iconFontFamily: selectedIcon.fontFamily??'MaterialIcons',
                    color: selectedColor.value,
                    frequency: controller.selectedFrequency.value,
                    startDate: controller.startDate.value,
                    endDate: controller.endDate.value,
                    streak: 0,
                    isCheck: 0,
                    selectedDate: controller.selectedDate.value
                  );
                  await  HabitDB.insertHabit(inserHabit.toMap());
await controller.getData();
Get.back();
                // Get.offAll(HomeScreen());
              }
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.darkPink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text("Create", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
      body: Obx(() => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Habit name
              TextFormField(
                controller: controller.habitController,
                decoration: const InputDecoration(
                  labelText: "Habit name",
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                validator: (value) =>
                value == null || value.trim().isEmpty ? "Habit name is required" : null,
              ),
              const SizedBox(height: 20),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.showColors.value
                          ? Colors.black
                          : Colors.grey.shade200,
                      foregroundColor: controller.showColors.value
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: () {
                      controller.showColors.value = true;
                      controller.tabVisible.value = !controller.tabVisible.value;
                    },
                    child: const Text("Color"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !controller.showColors.value
                          ? Colors.black
                          : Colors.grey.shade200,
                      foregroundColor: !controller.showColors.value
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: () {
                      controller.showColors.value = false;
                      controller.tabVisible.value = !controller.tabVisible.value;
                    },
                    child: const Text("Icon"),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              if (controller.tabVisible.value && controller.showColors.value)
                Wrap(
                  spacing: 12,
                  children: List.generate(controller.colors.length, (i) {
                    return GestureDetector(
                      onTap: () => controller.selectedColorIndex.value = i,
                      child: CircleAvatar(
                        backgroundColor: controller.colors[i],
                        child: controller.selectedColorIndex.value == i
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    );
                  }),
                ),
              if (controller.tabVisible.value && !controller.showColors.value)
                GridView.count(
                  crossAxisCount: 5,
                  shrinkWrap: true,
                  children: List.generate(controller.icons.length, (i) {
                    return GestureDetector(
                      onTap: () => controller.selectedIconIndex.value = i,
                      child: Icon(controller.icons[i],
                          color: controller.selectedIconIndex.value == i
                              ? Colors.pink
                              : Colors.black),
                    );
                  }),
                ),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () => controller.startDateMethod(context),
                child: dateMethod("Start date", controller.startDate.value),
              ),
              const SizedBox(height: 20),

              if (controller.selectedFrequency.value == "custom")
                GestureDetector(
                  onTap: () => controller.endDateMethod(context),
                  child: dateMethod("End date", controller.endDate.value),
                ),
              const SizedBox(height: 20),

              const Text("Frequency",
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              RadioListTile(
                value: "custom",
                groupValue: controller.selectedFrequency.value,
                title: const Text("Custom"),
                onChanged: (val) => controller.selectedFrequency.value = val!,
              ),
              RadioListTile(
                value: "Weekly",
                groupValue: controller.selectedFrequency.value,
                title: const Text("Weekly"),
                onChanged: (val) => controller.selectedFrequency.value = val!,
              ),
              RadioListTile(
                value: "Monthly",
                groupValue: controller.selectedFrequency.value,
                title: const Text("Monthly"),
                onChanged: (val) => controller.selectedFrequency.value = val!,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget dateMethod(String label, DateTime date) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            const SizedBox(height: 4),
            Text(DateFormat('d MMM y').format(date),
                style: const TextStyle(fontSize: 16)),
          ]),
          const Icon(Icons.calendar_today_outlined),
        ],
      ),
    );
  }
}
