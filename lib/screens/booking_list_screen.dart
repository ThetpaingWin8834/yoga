import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Expanded(child: CupertinoTextField()),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          )
        ],
      ),
    );
  }
}
