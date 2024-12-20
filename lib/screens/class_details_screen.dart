// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yoga/data/cart_manager.dart';
import 'package:yoga/models/cart_item.dart';
import 'package:yoga/models/class_detail.dart';
import 'package:yoga/models/class_item.dart';
import 'package:yoga/utils.dart';

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
              ? Center(
                  child: Text(error.toString()),
                )
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
      _isAlreadyAdded = CartManager.getCartItem(widget.classData.id) != null;
    });
  }

  void getDetails() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
        classDetail = null;
      });
      // await Future.delayed(const Duration(seconds: 3));
      final response = await http.post(
          Uri.parse('http://10.0.2.2/flowfityoga/getCourseById.php'),
          body: jsonEncode({'courseId': widget.classData.courseId.toString()}));
      final temp = jsonDecode(response.body);
      if (temp is! List<dynamic>) {
        setState(
          () {
            isLoading = false;
            error = 'Not Found';
          },
        );
        return;
      }
      final jsonList = temp;

      if (jsonList.isEmpty) {
        throw EmptyDataException();
      }

      setState(() {
        isLoading = false;
        error = null;
        classDetail = ClassDetail.fromMap(jsonList[0]);
        checkIsAdded();
      });
    } catch (e, s) {
      setState(() {
        isLoading = false;
        if (e is EmptyDataException) {
          error = 'Not Found';
        } else {
          error = "$e: $s";
        }
      });
    }
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
