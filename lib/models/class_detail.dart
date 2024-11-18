class ClassDetail {
  final int id;
  final String? dayOfWeek;
  final String? timeOfCourse;
  final String? capacityOfClass;
  final String? durationOfClass;
  final String? priceOfClass;
  final String? typeOfClass;
  final String? descriptionOfClass;
  final String? locationOfClass;
  ClassDetail({
    required this.id,
    required this.dayOfWeek,
    required this.timeOfCourse,
    required this.capacityOfClass,
    required this.durationOfClass,
    required this.priceOfClass,
    required this.typeOfClass,
    required this.descriptionOfClass,
    required this.locationOfClass,
  });

  ClassDetail copyWith({
    int? id,
    String? dayOfWeek,
    String? timeOfCourse,
    String? capacityOfClass,
    String? durationOfClass,
    String? priceOfClass,
    String? typeOfClass,
    String? descriptionOfClass,
    String? locationOfClass,
  }) {
    return ClassDetail(
      id: id ?? this.id,
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
      'id': id,
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

  factory ClassDetail.fromMap(Map<String, dynamic> map) {
    return ClassDetail(
      id: int.parse(map['id'].toString()),
      dayOfWeek: map['day_of_week'],
      timeOfCourse: map['time_of_course'],
      capacityOfClass: map['capacity_of_class'],
      durationOfClass: map['duration_of_class'],
      priceOfClass: map['price_of_class'],
      typeOfClass: map['type_of_class'],
      descriptionOfClass: map['description_of_class'],
      locationOfClass: map['location_of_class'],
    );
  }

  @override
  String toString() {
    return 'ClassDetails(id: $id, dayOfWeek: $dayOfWeek, timeOfCourse: $timeOfCourse, capacityOfClass: $capacityOfClass, durationOfClass: $durationOfClass, priceOfClass: $priceOfClass, typeOfClass: $typeOfClass, descriptionOfClass: $descriptionOfClass, locationOfClass: $locationOfClass)';
  }

  @override
  bool operator ==(covariant ClassDetail other) {
    if (identical(this, other)) return true;

    return other.id == id &&
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
    return id.hashCode ^
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
