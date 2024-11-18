// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ClassItem {
  final int id;
  final int courseId;
  final String dateOfClass;
  final String teacher;
  final String comments;
  ClassItem({
    required this.id,
    required this.courseId,
    required this.dateOfClass,
    required this.teacher,
    required this.comments,
  });

  ClassItem copyWith({
    int? id,
    int? courseId,
    String? dateOfClass,
    String? teacher,
    String? comments,
  }) {
    return ClassItem(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      dateOfClass: dateOfClass ?? this.dateOfClass,
      teacher: teacher ?? this.teacher,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseId': courseId,
      'date_of_class': dateOfClass,
      'teacher': teacher,
      'comments': comments,
    };
  }

  factory ClassItem.fromMap(Map<String, dynamic> map) {
    return ClassItem(
      id: map['id'],
      courseId: map['courseId'],
      dateOfClass: map['dateOfClass'] as String,
      teacher: map['teacher'] as String,
      comments: map['comments'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassItem.fromJson(String source) =>
      ClassItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassData(id: $id, courseId: $courseId, dateOfClass: $dateOfClass, teacher: $teacher, comments: $comments)';
  }

  @override
  bool operator ==(covariant ClassItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.courseId == courseId &&
        other.dateOfClass == dateOfClass &&
        other.teacher == teacher &&
        other.comments == comments;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        courseId.hashCode ^
        dateOfClass.hashCode ^
        teacher.hashCode ^
        comments.hashCode;
  }
}
