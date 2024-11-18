// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:yoga/data/cart_manager.dart';
import 'package:yoga/models/cart_item.dart';
import 'package:yoga/models/class_detail.dart';
import 'package:yoga/models/class_item.dart';

class ClassDetailsScreen extends StatefulWidget {
  final ClassItem classData;
  const ClassDetailsScreen({
    super.key,
    required this.classData,
  });

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  bool isLoading = true;
  Object? error;
  ClassDetail? classDetail;
  bool _isAlreadyAdded = false;

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Details'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : error != null
              ? const Center()
              : classDetail != null
                  ? Column(
                      children: [
                        ClassDetailTable2(
                          classDetail: classDetail,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          width: double.maxFinite,
                          child: FilledButton.icon(
                              style: FilledButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              icon: const Icon(Icons.shopping_cart),
                              onPressed: _isAlreadyAdded
                                  ? null
                                  : () {
                                      final classItem = widget.classData;
                                      CartManager.addCartItem(CartItem(
                                        classId: classItem.id,
                                        courseId: classItem.courseId,
                                        dateOfClass: classItem.dateOfClass,
                                        teacher: classItem.teacher,
                                        comments: classItem.comments,
                                        capacityOfClass:
                                            classDetail?.capacityOfClass,
                                        dayOfWeek: classDetail?.dayOfWeek,
                                        descriptionOfClass:
                                            classDetail?.descriptionOfClass,
                                        durationOfClass:
                                            classDetail?.durationOfClass,
                                        locationOfClass:
                                            classDetail?.locationOfClass,
                                        priceOfClass: classDetail?.priceOfClass,
                                        timeOfCourse: classDetail?.timeOfCourse,
                                        typeOfClass: classDetail?.typeOfClass,
                                      )).then(
                                        (value) {
                                          checkIsAdded();
                                        },
                                      );
                                    },
                              label: Text(_isAlreadyAdded
                                  ? 'Added to cart'
                                  : 'Add to cart')),
                        )
                      ],
                    )
                  : const SizedBox.shrink(),
    );
  }

  void checkIsAdded() {
    setState(() {
      _isAlreadyAdded = CartManager.getCartItem(classDetail?.id ?? '') != null;
    });
  }

  void getDetails() async {
    setState(() {
      isLoading = true;
      error = null;
      classDetail;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoading = false;
      error = null;
      classDetail = ClassDetail.fromMap({
        "id": widget.classData.id,
        "day_of_week": "Sunday",
        "time_of_course": "13:10",
        "capacity_of_class": "2 person",
        "duration_of_class": "60 hr",
        "price_of_class": "\$1000",
        "type_of_class": "Flow Yoga",
        "description_of_class": "Flow",
        "location_of_class": "Yangon"
      });
      checkIsAdded();
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}

class ClassDetailTable2 extends StatefulWidget {
  final ClassDetail? classDetail;

  const ClassDetailTable2({super.key, this.classDetail});

  @override
  State<ClassDetailTable2> createState() => _ClassDetailTable2State();
}

class _ClassDetailTable2State extends State<ClassDetailTable2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(), // Adjusts the width of the first column
          1: FlexColumnWidth(), // Second column takes the remaining space
        },
        border: TableBorder.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          width: 1,
          borderRadius: BorderRadius.circular(7),
        ),
        children: [
          tableRow('Type', widget.classDetail?.typeOfClass ?? '-'),
          tableRow('Day', widget.classDetail?.dayOfWeek ?? '-'),
          tableRow('Time', widget.classDetail?.timeOfCourse ?? '-'),
          tableRow('Location', widget.classDetail?.locationOfClass ?? '-'),
          tableRow('Capacity', widget.classDetail?.capacityOfClass ?? '-'),
          tableRow('Duration', widget.classDetail?.durationOfClass ?? '-'),
          tableRow('Price', widget.classDetail?.priceOfClass ?? '-'),
          tableRow(
              'Description', widget.classDetail?.descriptionOfClass ?? '-'),
        ],
      ),
    );
  }

  TableRow tableRow(String name, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
