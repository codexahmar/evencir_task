class WorkoutUtils {
  static void moveWorkout({
    required List<Map<String, dynamic>> weekDays,
    required int fromIndex,
    required int toIndex,
  }) {
    final workout = {
      "workoutType": weekDays[fromIndex]["workoutType"],
      "workoutColor": weekDays[fromIndex]["workoutColor"],
      "icon": weekDays[fromIndex]["icon"],
      "title": weekDays[fromIndex]["title"],
      "duration": weekDays[fromIndex]["duration"],
    };

    weekDays[fromIndex].remove("workoutType");
    weekDays[fromIndex].remove("workoutColor");
    weekDays[fromIndex].remove("icon");
    weekDays[fromIndex].remove("title");
    weekDays[fromIndex].remove("duration");
    weekDays[fromIndex]["hasWorkout"] = false;

    weekDays[toIndex]["hasWorkout"] = true;
    weekDays[toIndex]["workoutType"] = workout["workoutType"];
    weekDays[toIndex]["workoutColor"] = workout["workoutColor"];
    weekDays[toIndex]["icon"] = workout["icon"];
    weekDays[toIndex]["title"] = workout["title"];
    weekDays[toIndex]["duration"] = workout["duration"];
  }
}
