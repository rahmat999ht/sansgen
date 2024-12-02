class DateTimeServices {
  static final dateTimeNow = DateTime.now();
  static final listNameMonth = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Des"
  ];

  static String getDateTime(DateTime dateTime) {
    if (dateTime.year < dateTimeNow.year) {
      final namaMonth = listNameMonth[dateTime.month - 1];
      // Aug 2, 2022
      return "$namaMonth ${dateTime.day},${dateTime.year}";
    } else if (dateTime.month < dateTimeNow.month) {
      // 2 months ago
      return "${dateTimeNow.month - dateTime.month} bulan lalu";
    } else if (dateTime.day < dateTimeNow.day) {
      // 2 days lalu
      return "${dateTimeNow.day - dateTime.day} hari lalu";
    } else if (dateTime.hour < dateTimeNow.hour) {
      // 2 hours lalu
      return "${dateTimeNow.hour - dateTime.hour} jam lalu";
    } else if (dateTime.minute < dateTimeNow.minute) {
      return "${dateTimeNow.minute - dateTime.minute} menit lalu";
    }
    return "sekarang";
  }
}
