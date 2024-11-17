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
      body: const Column(
        children: [
          Row(
            children: [
              Expanded(child: CupertinoTextField()),
            ],
          )
        ],
      ),
    );
  }
}
