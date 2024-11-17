import 'package:flutter/material.dart';
import 'package:yoga/screens/booking_list_screen.dart';
import 'package:yoga/screens/cart_list_screen.dart';
import 'package:yoga/screens/home_screen.dart';
import 'package:yoga/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartListScreen(),
    const BookingListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          if (value != _selectedIndex) {
            setState(() {
              _selectedIndex = value;
            });
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(
              icon: Icon(Icons.shopping_cart_rounded), label: 'Cart '),
          NavigationDestination(
              icon: Icon(Icons.list_alt_rounded), label: 'Booking List'),
        ],
      ),
    );
  }
}
