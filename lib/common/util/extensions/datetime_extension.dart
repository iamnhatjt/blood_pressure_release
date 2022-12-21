extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    // if (day == this.weekday)
    //   return this.add(Duration(days: 7));
    // else {
      return add(
        Duration(
          days: (day - this.weekday) % DateTime.daysPerWeek,
        ),
      );
    // }
  }

  DateTime previous(int day) {
    // if (day == weekday) {
    //   return subtract(Duration(days: 7));
    // } else {
      return subtract(
        Duration(
          days: (this.weekday - day) % DateTime.daysPerWeek,
        ),
      );
    // }
  }
}