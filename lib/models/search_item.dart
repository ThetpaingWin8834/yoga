class SearchItem {
  final int id;
  final String dayOfWeek;
  final String timeOfCourse;
  final String capacityOfClass;
  final String durationOfClass;
  final String priceOfClass;
  final String typeOfClass;
  final String descriptionOfClass;
  final String locationOfClass;
  final int courseId;
  final String dateOfClass;
  final String teacher;
  final String comments;

  const SearchItem({
    required this.id,
    required this.dayOfWeek,
    required this.timeOfCourse,
    required this.capacityOfClass,
    required this.durationOfClass,
    required this.priceOfClass,
    required this.typeOfClass,
    required this.descriptionOfClass,
    required this.locationOfClass,
    required this.courseId,
    required this.dateOfClass,
    required this.teacher,
    required this.comments,
  });

  factory SearchItem.fromMap(Map<String, dynamic> map) {
    return SearchItem(
      id: int.parse(map['id'].toString()),
      dayOfWeek: map['day_of_week'] as String,
      timeOfCourse: map['time_of_course'] as String,
      capacityOfClass: map['capacity_of_class'] as String,
      durationOfClass: map['duration_of_class'] as String,
      priceOfClass: map['price_of_class'] as String,
      typeOfClass: map['type_of_class'] as String,
      descriptionOfClass: map['description_of_class'] as String,
      locationOfClass: map['location_of_class'] as String,
      courseId: map['courseId'] as int,
      dateOfClass: map['date_of_class'] as String,
      teacher: map['teacher'] as String,
      comments: map['comments'] as String,
    );
  }
  SearchItem copyWith({
    int? id,
    String? dayOfWeek,
    String? timeOfCourse,
    String? capacityOfClass,
    String? durationOfClass,
    String? priceOfClass,
    String? typeOfClass,
    String? descriptionOfClass,
    String? locationOfClass,
    int? courseId,
    String? dateOfClass,
    String? teacher,
    String? comments,
  }) {
    return SearchItem(
      id: id ?? this.id,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      timeOfCourse: timeOfCourse ?? this.timeOfCourse,
      capacityOfClass: capacityOfClass ?? this.capacityOfClass,
      durationOfClass: durationOfClass ?? this.durationOfClass,
      priceOfClass: priceOfClass ?? this.priceOfClass,
      typeOfClass: typeOfClass ?? this.typeOfClass,
      descriptionOfClass: descriptionOfClass ?? this.descriptionOfClass,
      locationOfClass: locationOfClass ?? this.locationOfClass,
      courseId: courseId ?? this.courseId,
      dateOfClass: dateOfClass ?? this.dateOfClass,
      teacher: teacher ?? this.teacher,
      comments: comments ?? this.comments,
    );
  }
}
