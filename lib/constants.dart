class Constants {
  static const String apiUrl =
      'https://d35e-2804-18-48ad-ddc0-582b-c878-4b89-a50f.ngrok-free.app/api';
  static const String baseEvents = '$apiUrl/events';
  static const String baseUser = '$apiUrl/auth';

}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 5, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 5, kToday.day);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}