// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yoga/models/class_item.dart';
import 'package:yoga/screens/class_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  Object? error;
  List<ClassItem> classlist = [];
  @override
  void initState() {
    super.initState();
    getAllClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Text(
              'Available Classes',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : error != null
                    ? Center(
                        child: Text(error.toString()),
                      )
                    : classlist.isEmpty
                        ? const Center(
                            child: Text('There is no available class'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return ClassItemWidget(
                                  classData: classlist[index]);
                            },
                            itemCount: classlist.length,
                          ),
          ),
        ],
      ),
    );
  }

  void getAllClasses() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });
      // await Future.delayed(const Duration(seconds: 2));
      final response =
          await http.get(Uri.parse('http://10.0.2.2/flowfityoga/getClass.php'));
      final jsonList = jsonDecode(response.body) as List<Map<String, dynamic>>;
      setState(() {
        isLoading = false;
        error = null;
        classlist =
            jsonList.map<ClassItem>((json) => ClassItem.fromMap(json)).toList();
        // classlist = List.generate(
        //   100,
        //   (index) => ClassItem(
        //       id: index,
        //       courseId: index,
        //       dateOfClass: formatDateToString(DateTime.now()),
        //       teacher: 'Teacher $index',
        //       comments: 'comment'),
        // );
      });
    } catch (e, s) {
      setState(() {
        isLoading = false;
        error = "$e: $s";
      });
    }
  }
}

class ClassItemWidget extends StatelessWidget {
  final ClassItem classData;
  const ClassItemWidget({
    super.key,
    required this.classData,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Teacher : ${classData.teacher}',
              style: themeData.textTheme.labelLarge,
            ),
            Text('Date : ${classData.dateOfClass}'),
            Text('Comment : ${classData.comments}'),
            const SizedBox(height: 12),
            const Divider(),
            SizedBox(
                width: double.maxFinite,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                ClassDetailsScreen(classData: classData),
                          ));
                    },
                    child: const Text('More Details'))),
          ],
        ),
      ),
    );
  }
}
