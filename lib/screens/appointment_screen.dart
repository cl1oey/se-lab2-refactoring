// lib/views/screens/appointments_screen.dart
//
// NOTE: In the real thesis project this class extends StatefulWidget and
// renders the appointments screen. For this lab submission we keep only
// the pure helper functions needed to demonstrate the refactor, so the
// file compiles standalone under `flutter test`.

/// Minimal model used by the appointments screen.
/// In the real project this lives in lib/models/appointment.dart.
class Appointment {
  final String date;
  const Appointment({required this.date});
}

/// Parses [raw] into a DateTime, or returns null if it is not a valid date.
DateTime? _tryParseDate(String raw) {
  if (raw.isEmpty) return null;
  return DateTime.tryParse(raw);
}

/// True when [a] and [b] fall on the same calendar day (time ignored).
bool _isSameCalendarDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Returns the appointments that fall on [day].
List<Appointment> _getAppointmentsForDay(
  DateTime day,
  List<Appointment> appointments,
) {
  return appointments.where((appointment) {
    final parsed = _tryParseDate(appointment.date);
    return parsed != null && _isSameCalendarDay(parsed, day);
  }).toList();
}
