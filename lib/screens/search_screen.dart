import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yoga/models/search_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;
  Object? error;
  List<SearchItem> searchList = [];
  final List<SearchItem> _allData = [];
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    // getAllClasses();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            child: Row(
              children: [
                Expanded(
                    child: CupertinoTextField(
                  controller: _controller,
                  placeholder: 'Enter day of week',
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
          const SizedBox(height: 7),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : error != null
                    ? Center(
                        child: Text(error.toString()),
                      )
                    : searchList.isEmpty
                        ? Center(
                            child: Text(_controller.text.trim().isEmpty
                                ? 'Search with day of week'
                                : 'There is no available class'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return SearchItemWidget(
                                  searchItem: searchList[index]);
                            },
                            itemCount: searchList.length,
                          ),
          ),
        ],
      ),
    );
  }

  void onSearch(String text) async {
    try {
      if (text.isEmpty) {
        ScaffoldMessenger.maybeOf(context)
            ?.showSnackBar(const SnackBar(content: Text('Enter day of week')));
        return;
      }
      setState(
        () {
          isLoading = true;
          error = null;
        },
      );
      final response = await http.post(
          Uri.parse('http://10.0.2.2/flowfityoga/searchClass.php'),
          body: jsonEncode({'day': text}));
      final json = jsonDecode(response.body);
      if (json is! List<dynamic>) {
        setState(
          () {
            isLoading = false;
            error = 'Not Found';
          },
        );
        return;
      }
      final jsonList = json;
      setState(
        () {
          isLoading = false;
          error = null;
          final temp = jsonList
              .map<SearchItem>((json) => SearchItem.fromMap(json))
              .toList();
          searchList = temp;
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
    //       searchList = _allData;
    //     } else {
    //       searchList = _allData.where((item) {
    //         return item.dateOfClass
    //                 .toLowerCase()
    //                 .contains(text.toLowerCase()) ||
    //             item.teacher.toLowerCase().contains(text.toLowerCase()) ||
    //             item.locationOfClass
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
      searchList = List.generate(
        100,
        (index) => SearchItem.fromMap(
          {
            "id": index,
            "day_of_week": "Sunday",
            "time_of_course": "19:51",
            "capacity_of_class": "2 person",
            "duration_of_class": "1 hr",
            "price_of_class": "\$100",
            "type_of_class": "Flow Yoga",
            "description_of_class": "Flow",
            "location_of_class": "Yangon",
            "courseId": 6,
            "date_of_class": "17/11/2024",
            "teacher": "Alex",
            "comments": "Good"
          },
        ),
      );
      _allData.addAll(searchList);
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }
}

class SearchItemWidget extends StatelessWidget {
  final SearchItem searchItem;

  const SearchItemWidget({super.key, required this.searchItem});

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              searchItem.typeOfClass,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themedata.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem('Day', searchItem.dayOfWeek),
                _buildDetailItem('Time', searchItem.timeOfCourse),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem('Duration', searchItem.durationOfClass),
                _buildDetailItem('Price', searchItem.priceOfClass),
              ],
            ),
            const SizedBox(height: 8),
            _buildDetailItem('Location', searchItem.locationOfClass),
            const Divider(),
            Text(
              'Teacher: ${searchItem.teacher}',
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 4),
            Text(
              'Comments: ${searchItem.comments}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
