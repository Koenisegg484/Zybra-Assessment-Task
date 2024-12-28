class Task {
  int? id;
  String title;
  String description;
  DateTime? startDate;
  DateTime? dueDate;
  String? priority;
  String? tags;
  bool status;
  String? startTime;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.startDate,
    this.dueDate,
    this.priority,
    this.tags,
    this.status = false,
    this.startTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate?.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority,
      'tags': tags,
      'status': status ? 1 : 0,
      'startTime': startTime,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      startDate: map['startDate'] != null ? DateTime.parse(map['startDate']) : null,
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      priority: map['priority'],
      tags: map['tags'],
      status: map['status'] == 1,
      startTime: map['startTime'],
    );
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? priority,
    String? tags,
    DateTime? startDate,
    DateTime? dueDate,
    String? startTime,
    bool? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      tags: tags ?? this.tags,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      startTime: startTime ?? this.startTime,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }
}
