import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/class_item.dart';
import '../utils.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  bool isLoading = false;
  Object? error;
  List<ClassItem> classlist = [];
  final List<ClassItem> _allData = [];
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            child: Row(
              children: [
                Expanded(
                    child: CupertinoTextField(
                  controller: _controller,
                  placeholder: 'Enter email',
                )),
                const SizedBox(width: 12),
                FilledButton.tonal(
                  onPressed: () {
                    onSearch(_controller.text.trim());
                  },
                  child: const Text('Search'),
                )
              ],
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
                        ? Center(
                            child: Text(_controller.text.trim().isEmpty
                                ? 'Search with email'
                                : 'There is no available class'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return BookingClassItemWidget(
                                  classData: classlist[index]);
                            },
                            itemCount: classlist.length,
                          ),
          ),
        ],
      ),
    );
  }

  void onSearch(String text) async {
    try {
      final isValid = isValidEmail(text);
      if (!isValid) {
        ScaffoldMessenger.maybeOf(context)
            ?.showSnackBar(const SnackBar(content: Text('Invalid email')));
        return;
      }
      setState(
        () {
          isLoading = true;
          error = null;
        },
      );
      final response = await http.post(
          Uri.parse('http://10.0.2.2/flowfityoga/bookinglist.php'),
          body: jsonEncode({'email': text}));
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      setState(
        () {
          isLoading = false;
          error = null;
          final temp = jsonList
              .map<ClassItem>((json) => ClassItem.fromMap(json))
              .toList();
          classlist = temp;
        },
      );
    } catch (e) {
      setState(
        () {
          isLoading = false;
          error = e.toString();
        },
      );
    }
    // setState(
    //   () {
    //     if (text.isEmpty) {
    //       classlist = _allData;
    //     } else {
    //       classlist = _allData.where((item) {
    //         return item.dateOfClass
    //                 .toLowerCase()
    //                 .contains(text.toLowerCase()) ||
    //             item.teacher.toLowerCase().contains(text.toLowerCase());
    //       }).toList();
    //     }
    //   },
    // );
  }

  void getAllClasses() async {
    setState(() {
      isLoading = true;
      error = null;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
      error = null;
      classlist = List.generate(
        100,
        (index) => ClassItem(
            id: index,
            courseId: index,
            dateOfClass: formatDateToString(DateTime.now()),
            teacher: 'Teacher $index',
            comments: 'comment'),
      );
      _allData.addAll(classlist);
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }
}

class BookingClassItemWidget extends StatelessWidget {
  final ClassItem classData;
  const BookingClassItemWidget({
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
          ],
        ),
      ),
    );
  }
}
