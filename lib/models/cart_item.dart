// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 3)
class CartItem {
  @HiveField(0)
  final int classId;
  @HiveField(1)
  final int courseId;
  @HiveField(2)
  final String dateOfClass;
  @HiveField(3)
  final String teacher;
  @HiveField(4)
  final String comments;
  @HiveField(5)
  final String? dayOfWeek;
  @HiveField(6)
  final String? timeOfCourse;
  @HiveField(7)
  final String? capacityOfClass;
  @HiveField(8)
  final String? durationOfClass;
  @HiveField(9)
  final String? priceOfClass;
  @HiveField(10)
  final String? typeOfClass;
  @HiveField(11)
  final String? descriptionOfClass;
  @HiveField(12)
  final String? locationOfClass;
  CartItem({
    required this.classId,
    required this.courseId,
    required this.dateOfClass,
    required this.teacher,
    required this.comments,
    this.dayOfWeek,
    this.timeOfCourse,
    this.capacityOfClass,
    this.durationOfClass,
    this.priceOfClass,
    this.typeOfClass,
    this.descriptionOfClass,
    this.locationOfClass,
  });

  CartItem copyWith({
    int? classId,
    int? courseId,
    String? dateOfClass,
    String? teacher,
    String? comments,
    String? dayOfWeek,
    String? timeOfCourse,
    String? capacityOfClass,
    String? durationOfClass,
    String? priceOfClass,
    String? typeOfClass,
    String? descriptionOfClass,
    String? locationOfClass,
  }) {
    return CartItem(
      classId: classId ?? this.classId,
      courseId: courseId ?? this.courseId,
      dateOfClass: dateOfClass ?? this.dateOfClass,
      teacher: teacher ?? this.teacher,
      comments: comments ?? this.comments,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      timeOfCourse: timeOfCourse ?? this.timeOfCourse,
      capacityOfClass: capacityOfClass ?? this.capacityOfClass,
      durationOfClass: durationOfClass ?? this.durationOfClass,
      priceOfClass: priceOfClass ?? this.priceOfClass,
      typeOfClass: typeOfClass ?? this.typeOfClass,
      descriptionOfClass: descriptionOfClass ?? this.descriptionOfClass,
      locationOfClass: locationOfClass ?? this.locationOfClass,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'classId': classId,
      'courseId': courseId,
      'dateOfClass': dateOfClass,
      'teacher': teacher,
      'comments': comments,
      'dayOfWeek': dayOfWeek,
      'timeOfCourse': timeOfCourse,
      'capacityOfClass': capacityOfClass,
      'durationOfClass': durationOfClass,
      'priceOfClass': priceOfClass,
      'typeOfClass': typeOfClass,
      'descriptionOfClass': descriptionOfClass,
      'locationOfClass': locationOfClass,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      classId: map['classId'],
      courseId: map['courseId'],
      dateOfClass: map['dateOfClass'] as String,
      teacher: map['teacher'] as String,
      comments: map['comments'] as String,
      dayOfWeek: map['dayOfWeek'] != null ? map['dayOfWeek'] as String : null,
      timeOfCourse:
          map['timeOfCourse'] != null ? map['timeOfCourse'] as String : null,
      capacityOfClass: map['capacityOfClass'] != null
          ? map['capacityOfClass'] as String
          : null,
      durationOfClass: map['durationOfClass'] != null
          ? map['durationOfClass'] as String
          : null,
      priceOfClass:
          map['priceOfClass'] != null ? map['priceOfClass'] as String : null,
      typeOfClass:
          map['typeOfClass'] != null ? map['typeOfClass'] as String : null,
      descriptionOfClass: map['descriptionOfClass'] != null
          ? map['descriptionOfClass'] as String
          : null,
      locationOfClass: map['locationOfClass'] != null
          ? map['locationOfClass'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItem(classId: $classId, courseId: $courseId, dateOfClass: $dateOfClass, teacher: $teacher, comments: $comments, dayOfWeek: $dayOfWeek, timeOfCourse: $timeOfCourse, capacityOfClass: $capacityOfClass, durationOfClass: $durationOfClass, priceOfClass: $priceOfClass, typeOfClass: $typeOfClass, descriptionOfClass: $descriptionOfClass, locationOfClass: $locationOfClass)';
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.classId == classId &&
        other.courseId == courseId &&
        other.dateOfClass == dateOfClass &&
        other.teacher == teacher &&
        other.comments == comments &&
        other.dayOfWeek == dayOfWeek &&
        other.timeOfCourse == timeOfCourse &&
        other.capacityOfClass == capacityOfClass &&
        other.durationOfClass == durationOfClass &&
        other.priceOfClass == priceOfClass &&
        other.typeOfClass == typeOfClass &&
        other.descriptionOfClass == descriptionOfClass &&
        other.locationOfClass == locationOfClass;
  }

  @override
  int get hashCode {
    return classId.hashCode ^
        courseId.hashCode ^
        dateOfClass.hashCode ^
        teacher.hashCode ^
        comments.hashCode ^
        dayOfWeek.hashCode ^
        timeOfCourse.hashCode ^
        capacityOfClass.hashCode ^
        durationOfClass.hashCode ^
        priceOfClass.hashCode ^
        typeOfClass.hashCode ^
        descriptionOfClass.hashCode ^
        locationOfClass.hashCode;
  }
}
