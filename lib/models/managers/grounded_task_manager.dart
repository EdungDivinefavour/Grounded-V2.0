import 'package:grounded/models/data_points/daily_data_point.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';

class GroundedTaskManager {
  GroundedTaskManager._();
  static final GroundedTaskManager _instance = GroundedTaskManager._();
  static GroundedTaskManager get instance => _instance;

  List<DailyDataPoint> getDailyDataPointsThisWeek(List<GroundedTask> tasks) {
    final List<DailyDataPoint> dailyDataPoints = [];

    for (final day in daysInThisWeek) {
      final tasksCompletedOnDay = tasks
          .where((task) => task.wasCompletedThisWeek)
          .where((x) => x.wasCompletedOnDay(day))
          .length;

      if (tasksCompletedOnDay == 0) {
        dailyDataPoints
            .add(DailyDataPoint(dayOfWeek: day.weekday, completedTasks: 0));
      } else {
        dailyDataPoints.add(DailyDataPoint(
            dayOfWeek: day.weekday, completedTasks: tasksCompletedOnDay));
      }
    }
    return dailyDataPoints;
  }

  List<DateTime> get daysInThisWeek {
    List<DateTime> daysInWeek = [];
    final now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      daysInWeek.add(DateTime(now.year, now.month, now.day + i));
    }

    return daysInWeek;
  }
}
