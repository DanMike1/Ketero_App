import 'dart:convert';

class AppEvent {
  final String title;
  final String id;
  final String description;
  final DateTime date;
  final String userId;
  final bool completed;
  final bool reminder;

  AppEvent(
    this.title,
    this.id,
    this.description,
    this.date,
    this.userId,
    this.completed,
    this.reminder,
  );

  AppEvent copyWith({
    String? title,
    String? id,
    String? description,
    DateTime? date,
    String? userId,
    bool? completed,
    bool? reminder,
  }) {
    return AppEvent(
      title ?? this.title,
      id ?? this.id,
      description ?? this.description,
      date ?? this.date,
      userId ?? this.userId,
      completed ?? this.completed,
      reminder ?? this.reminder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'userId': userId,
      'completed': completed,
      'reminder': reminder,
    };
  }

  factory AppEvent.fromMap(Map<String, dynamic> map) {
    return AppEvent(
      map['title'],
      map['id'],
      map['description'],
      DateTime.fromMillisecondsSinceEpoch(map['date']),
      map['userId'],
      map['completed'],
      map['reminder'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppEvent.fromJson(String source) =>
      AppEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppEvent(title: $title, id: $id, description: $description, date: $date, userId: $userId, completed: $completed, reminder: $reminder)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppEvent &&
        other.title == title &&
        other.id == id &&
        other.description == description &&
        other.date == date &&
        other.userId == userId &&
        other.completed == completed &&
        other.reminder == reminder;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        description.hashCode ^
        date.hashCode ^
        userId.hashCode ^
        completed.hashCode ^
        reminder.hashCode;
  }
}
