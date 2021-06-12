import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String createdBy;
  final DateTime deadline;
  final String name;
  final String status;
  final String taskAssignedTo;

  const Event(this.createdBy, this.deadline, this.name, this.status,
      this.taskAssignedTo);

  @override
  String toString() => createdBy;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(2020, 10, item * 5),
    value: (item) => List.generate(
        item % 4 + 1,
        (index) => Event(
              'Event $item | ${index + 1}',
              DateTime.utc(2020, 10, item * 5),
              "garbage",
              "garbage",
              "garbage",
            )))
  ..addAll({
    DateTime.now(): [
      Event(
        'Event aksdfbj',
        DateTime.now(),
        "garbage",
        "garbage",
        "garbage",
      ),
      Event(
        'Event aksdfn',
        DateTime.now(),
        "garbage",
        "garbage",
        "garbage",
      ),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);
