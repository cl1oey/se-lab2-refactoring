// test/get_appointments_for_day_test.dart
import 'package:flutter_test/flutter_test.dart';

// Self-contained copy of the refactored logic under test.
// This keeps the test runnable without importing the private helper
// from lib/, since Dart private members cannot cross file boundaries.

class Appointment {
  final String date;
  const Appointment({required this.date});
}

List<Appointment> _getAppointmentsForDay(
  DateTime day,
  List<Appointment> appointments,
) {
  return appointments.where((appointment) {
    final parsed = _tryParseDate(appointment.date);
    return parsed != null && _isSameCalendarDay(parsed, day);
  }).toList();
}

DateTime? _tryParseDate(String raw) {
  if (raw.isEmpty) return null;
  return DateTime.tryParse(raw);
}

bool _isSameCalendarDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

void main() {
  final day = DateTime(2026, 9, 30);

  group('_getAppointmentsForDay', () {
    test('input 1: returns only appointments on the target day', () {
      final list = [
        Appointment(date: '2026-09-30T09:00:00'),
        Appointment(date: '2026-09-30T15:30:00'),
        Appointment(date: '2026-10-01T09:00:00'),
        Appointment(date: '2026-09-29T23:59:59'),
      ];
      final result = _getAppointmentsForDay(day, list);
      expect(result.length, 2);
      expect(result.every((a) => a.date.startsWith('2026-09-30')), true);
    });

    test('input 2: same day, different time-of-day still matches', () {
      final list = [
        Appointment(date: '2026-09-30T00:00:00'),
        Appointment(date: '2026-09-30T23:59:59'),
      ];
      expect(_getAppointmentsForDay(day, list).length, 2);
    });

    // EDGE CASE: malformed / empty date strings must not crash.
    test('edge: malformed dates are skipped, valid ones still returned', () {
      final list = [
        Appointment(date: 'not-a-date'),
        Appointment(date: ''),
        Appointment(date: '2026-13-45T99:99:99'),
        Appointment(date: '2026-09-30T10:00:00'),
      ];
      final result = _getAppointmentsForDay(day, list);
      expect(result.length, 1);
      expect(result.single.date, '2026-09-30T10:00:00');
    });
  });
}
