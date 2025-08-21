import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Habit {
  final int id;
  final String name;
  final IconData? icon;
  final Color color;
  final int streak;
  final bool isCheck;
  final String frequency; // weekly or monthly .......................
  final DateTime? startDate;
  final DateTime? endDate;

  Habit({
    this.id = 0,
     this.name="",
     this.icon,
     this.color=Colors.red,
     this.streak=0,
     this.frequency="",
     this.startDate,
     this.endDate,
     this.isCheck=false
  });

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      color: Color(map['color']),
      frequency: map['frequency'],
      startDate: DateTime.parse(map['start_date']),
      endDate: map['end_Date'],
      streak: map['streak'], isCheck: map['isCheck'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
      'frequency': frequency,
      'start_date': startDate?.toIso8601String(),
      'end_Date': endDate,
      'streak': streak,
      'isCheck':isCheck
    };
  }
}
