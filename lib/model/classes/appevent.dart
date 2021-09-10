import 'dart:convert';

class AppEvent {
  final String title;
  final String? id;
  final String description;
  final DateTime target_date;
  final String? userId;
  final bool? completed;
  final bool? reminder;

  AppEvent({
    required this.title,
    this.id,
    required this.description,
    required this.target_date,
    this.userId,
    this.completed,
    this.reminder,
  });

  AppEvent copyWith({
    String? title,
    String? id,
    String? description,
    DateTime? target_date,
    String? userId,
    bool? completed,
    bool? reminder,
  }) {
    return AppEvent(
      title: title ?? this.title,
      id: id ?? this.id,
      description: description ?? this.description,
      target_date: target_date ?? this.target_date,
      userId: userId ?? this.userId,
      completed: completed ?? this.completed,
      reminder: reminder ?? this.reminder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'description': description,
      'target_date': target_date.millisecondsSinceEpoch,
      'userId': userId,
      'completed': completed,
      'reminder': reminder,
    };
  }

  factory AppEvent.fromMap(Map<String, dynamic> map) {
    return AppEvent(
      title: map['title'],
      id: map['id'],
      description: map['description'],
      target_date: DateTime.fromMillisecondsSinceEpoch(map['target_date']),
      userId: map['userId'],
      completed: map['completed'],
      reminder: map['reminder'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppEvent.fromJson(Map<String, dynamic> json) {
    return AppEvent(
        title: json['title'],
        description: json['description'],
        target_date: DateTime.parse(json['target_date']));
  }

  // factory AppEvent.fromJson(String source) =>
  //     AppEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppEvent(title: $title, id: $id, description: $description, target_date: $target_date, userId: $userId, completed: $completed, reminder: $reminder)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppEvent &&
        other.title == title &&
        other.id == id &&
        other.description == description &&
        other.target_date == target_date &&
        other.userId == userId &&
        other.completed == completed &&
        other.reminder == reminder;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        description.hashCode ^
        target_date.hashCode ^
        userId.hashCode ^
        completed.hashCode ^
        reminder.hashCode;
  }
}
