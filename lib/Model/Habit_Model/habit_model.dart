
class Habit {
  final int? id;
  final String name;
  final int icon;
  final int color;
  final int streak;
   int isCheck;
  final String iconFontFamily;
  final String frequency;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? selectedDate;

  Habit({
    this.id,
     this.name="",
     this.icon=0,
     this.color=0,
     this.streak=0,
     this.frequency="",
     this.startDate,
    this.iconFontFamily="",
     this.endDate,
    this.isCheck=0,
    this.selectedDate
  });

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      color: map['color'],
      frequency: map['frequency'],
      iconFontFamily: map['iconFontFamily'],
      startDate: map['start_Date'] != null ? DateTime.parse(map['start_Date']) : null,
      endDate: map['end_Date'] != null ? DateTime.parse(map['end_Date']) : null,
      streak: map['streak'], isCheck: map['isCheck'],selectedDate:  map['selectedDate'] != null ? DateTime.parse(map['selectedDate']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
      'frequency': frequency,
      'start_date': startDate.toString(),
      'end_Date': endDate.toString(),
      'streak': streak,
      'isCheck':isCheck,
      'selectedDate':selectedDate.toString(),
      'iconFontFamily':iconFontFamily
    };
  }
}

class HabitCompletion {
  int? id;
  int? habitId;
  String? date;
  int streak;
  int isCheck;

  HabitCompletion({
    this.id,
     this.habitId,
     this.date,
    this.streak=0,
     this.isCheck=0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habit_id': habitId,
      'date': date,
      'streak':streak,
      'isCheck': isCheck,
    };
  }

  factory HabitCompletion.fromMap(Map<String, dynamic> map) {
    return HabitCompletion(
      id: map['id'],
      habitId: map['habit_id'],
      date: map['date'],
      streak: map['streak'],
      isCheck: map['isCheck'],
    );
  }
}
