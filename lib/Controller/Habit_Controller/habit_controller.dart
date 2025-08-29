import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker_app/Model/Habit_Model/habit_model.dart';
import 'package:habit_tracker_app/Services/Db_Services/db_services.dart';

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
  RxList habitDates = <DateTime>[].obs;

  final RxList<Color> colors =
      [
        Colors.yellow,
        Colors.orange,
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.teal,
        Colors.pink,
        Colors.purple,
        Colors.lightBlue,
        Colors.cyan,
      ].obs;

  final RxList<IconData> icons =
      [
        Icons.sports_soccer,
        Icons.wb_sunny,
        Icons.book,
        Icons.water_drop,
        Icons.restaurant,
        Icons.brightness_3,
        Icons.music_note,
        Icons.sports,
        Icons.flight,
        Icons.camera_alt,
        Icons.code,
        Icons.check,
        Icons.light_mode,
        Icons.nightlight,
        Icons.pets,
        Icons.cleaning_services,
      ].obs;

  // final RxList<int> icons = [
  //   Icon('&#128507'), Icons.wb_sunny, Icons.book, Icons.water_drop,
  //   Icons.restaurant, Icons.brightness_3, Icons.music_note, Icons.sports,
  //   Icons.flight, Icons.camera_alt, Icons.code, Icons.check,
  //   Icons.light_mode, Icons.nightlight, Icons.pets, Icons.cleaning_services,
  // ].obs;

  RxBool showColors = true.obs;
  RxInt selectedColorIndex = 0.obs;
  RxInt selectedIconIndex = 0.obs;
  var tabVisible = false.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
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

  Future<void> getData() async {
    var l = await HabitDB.getHabits();
    habitList.value = l.map((e) => Habit.fromMap(e)).toList();
    print("list::::${l.length}--${habitList.map((e) => e.toMap())}");
    update();
  }
}
