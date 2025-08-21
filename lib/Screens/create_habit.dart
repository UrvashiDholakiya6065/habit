import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:habit_tracker_app/Const/app_color.dart';
import 'package:habit_tracker_app/Controller/Habit_Controller/habit_controller.dart';
import 'package:habit_tracker_app/Model/Habit_Model/habit_model.dart';
import 'package:habit_tracker_app/Screens/home_screen.dart';
import 'package:intl/intl.dart';

class CreateHabit extends StatelessWidget {
  CreateHabit({super.key});

  final controller = Get.find<HabitController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPink,
      appBar: AppBar(
        title: Text('Create Habit'),
                       actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.habitList.add(Habit(
                    name: controller.habitController.text,
                    icon: controller.icons[controller.selectedIconIndex.value],
                    color: controller.colors[controller.selectedColorIndex.value],
                    frequency: controller.selectedFrequency.value,
                    startDate: controller.startDate.value,
                    endDate: controller.endDate.value, streak: 0, isCheck: false,
                  ));

                  print("Selected Frequancy :::::${controller.selectedFrequency.value}");
                  Get.offAll(HomeScreen());
                }
              },
              child: Container(
                height: 40,
                width: 90,
                decoration: BoxDecoration(
                  color: AppColors.darkPink,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Create',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: controller.habitController,
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          labelText: 'Habit name',
                          labelStyle: TextStyle(color: Colors.grey[700]),
                          filled: true,
                          fillColor: Color(0xFFF5F5F5),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Habit name is required.';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      DropdownButtonFormField<String>(
                        value: controller.selectedCategory.value,
                        decoration: InputDecoration(
                          labelText: 'Category',
                          filled: true,
                          fillColor: Color(0xFFF5F5F5),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        icon: Icon(Icons.keyboard_arrow_down),
                        items:
                            controller.categories.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          controller.selectedCategory.value = newValue!;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTabButton(
                            "Color",
                            Obx(() => CircleAvatar(
                              radius: 10,
                              backgroundColor: controller.colors[controller.selectedColorIndex.value],
                            )),
                          ),
                          SizedBox(width: 10),
                          _buildTabButton(
                            "Icon",
                            Obx(() => Icon(
                              controller.icons[controller.selectedIconIndex.value],
                              size: 20,
                              color: Colors.black,
                            )),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      controller.tabVisible.value
                          ? (controller.showColors.value ? _buildColorSelector() : _buildIconSelector())
                          : SizedBox.shrink(),

                      SizedBox(height: 20),
                  Obx((){
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.startDateMethod(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start date',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      DateFormat(
                                        'd MMM y',
                                      ).format(controller.startDate.value),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.calendar_today_outlined),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        if(controller.selectedFrequency.value=="custom")
                        GestureDetector(
                          onTap: () {
                            controller.endDateMethod(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'End date',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      DateFormat(
                                        'd MMM y',
                                      ).format(controller.endDate.value),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.calendar_today_outlined),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                      SizedBox(height: 20),
                      Text(
                        'Frequency',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),

                      RadioListTile(
                        value: 'custom',
                        groupValue: controller.selectedFrequency.value,
                        activeColor: Colors.pink,
                        title: Text('custom'),
                        onChanged: (value) {
                          controller.selectedFrequency.value = value!;
                        },
                      ),
                      SizedBox(height: 8),

                      RadioListTile(
                        value: "Weekly",
                        groupValue: controller.selectedFrequency.value,
                        activeColor: Colors.pink,
                        title: Text("Weekly"),
                        onChanged: (value) {
                          controller.selectedFrequency.value = value!;
                        },
                      ),
                      RadioListTile(
                        value: 'Monthly',
                        groupValue: controller.selectedFrequency.value,
                        activeColor: Colors.pink,
                        title: Text('Monthly'),
                        onChanged: (value) {
                          controller.selectedFrequency.value = value!;
                        },
                      ),

                    ],
                  ),


                  ),
                ),
              ),


            ),
          ),
        ),

    );
  }
  Widget _buildColorSelector() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(controller.colors.length, (index) {
        final isSelected = controller.selectedColorIndex.value == index;
        return GestureDetector(
          onTap: (){
            controller.selectedColorIndex.value = index;
          },
          child: CircleAvatar(
            radius: isSelected ? 22 : 20,
            backgroundColor: controller.colors[index],
            child: isSelected ? Icon(Icons.check, color: Colors.white, size: 20) : null,
          ),
        );
      }),
    );
  }

  // Icon Selection UI
  Widget _buildIconSelector() {
    return GridView.count(
      crossAxisCount: 5,
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(controller.icons.length, (index) {
        final isSelected = controller.selectedIconIndex.value == index;
        return GestureDetector(
          onTap: (){
          controller.selectedIconIndex.value = index;
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey.shade300 : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              controller.icons[index],
              size: 30,
              color: Colors.black,
            ),
          ),
        );
      }),
    );
  }


  Widget _buildTabButton(String title, Widget preview) {
    final isSelected = (title == "Color" && controller.showColors.value == true) ||
        (title == "Icon" && controller.showColors.value == false && controller.tabVisible.value);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            foregroundColor: isSelected ? Colors.white : Colors.black,
            backgroundColor: isSelected ? Colors.black : Colors.grey.shade200,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          icon: title == "Color"
              ? Icon(Icons.circle, size: 16)
              : Icon(Icons.local_cafe, size: 16),
          label: Text(title),
          onPressed: () {
            if (title == "Color") {
              if (controller.showColors.value && controller.tabVisible.value) {
                controller.tabVisible.value = false;
              } else {
                controller.showColors.value = true;
                controller.tabVisible.value = true;
              }
            } else {
              if (!controller.showColors.value && controller.tabVisible.value) {
                controller.tabVisible.value = false;
              } else {
                controller.showColors.value = false;
                controller.tabVisible.value = true;
              }
            }
          },
        ),
        SizedBox(width: 6),
        preview,
      ],
    );
  }



}


