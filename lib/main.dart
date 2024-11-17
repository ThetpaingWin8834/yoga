import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yoga/models/cart_item.dart';
import 'package:yoga/screens/main_screen.dart';

void main() async {
  await initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yoga',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))))),
      home: const MainScreen(),
    );
  }
}

const cartBoxName = 'yoga_cart';
Future initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>(cartBoxName);
}
