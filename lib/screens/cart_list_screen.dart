// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yoga/data/cart_manager.dart';
import 'package:yoga/models/cart_item.dart';

import '../utils.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  List<CartItem> _cartList = [];
  @override
  void initState() {
    super.initState();
    getAllItemsFromCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart List'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: onClearAllClick,
            child: const Text(
              'Clear All',
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
      body: _cartList.isEmpty
          ? const Center(
              child: Text('No items in cart'),
            )
          : ListView.builder(
              itemCount: _cartList.length,
              itemBuilder: (context, index) {
                final cartItem = _cartList[index];
                return CartItemWidget(
                  cartItem: cartItem,
                  onBook: () => onBook(cartItem),
                  onRemove: () => onRemove(cartItem),
                );
              }),
    );
  }

  void onRemove(CartItem item) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text.rich(TextSpan(children: [
          const TextSpan(text: 'Are you sure you want remove '),
          TextSpan(
              text: item.typeOfClass,
              style: const TextStyle(decoration: TextDecoration.lineThrough)),
          const TextSpan(text: ' from cart list'),
        ])),
        actions: [
          CupertinoDialogAction(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
              CartManager.removeCartItem(item.classId);
              getAllItemsFromCart();
            },
          ),
        ],
      ),
    );
  }

  void onBook(CartItem item) {
    final controller = TextEditingController();
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        content: CupertinoTextField(
          controller: controller,
          placeholder: 'Enter your email',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Later'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            textStyle: const TextStyle(color: Colors.green),
            child: const Text('Book Now'),
            onPressed: () {
              final text = controller.text.trim();
              final isValid = isValidEmail(text);

              if (!isValid) {
                ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                    const SnackBar(content: Text('Invalid email')));
                Navigator.pop(context);
                return;
              }
              Navigator.pop(context);
              bookNow(item, text);
            },
          ),
        ],
      ),
    ).then(
      (value) {
        controller.dispose();
      },
    );
  }

  void bookNow(CartItem item, String email) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/flowfityoga/booking.php'),
        body: jsonEncode({
          'class_id': item.classId,
          'email': email,
        }),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Success')));
        CartManager.removeCartItem(item.classId);
        getAllItemsFromCart();
      }
    } catch (e, s) {
      log(s.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  void getAllItemsFromCart() {
    setState(() {
      _cartList = CartManager.getAllCartItems();
    });
  }

  void onClearAllClick() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text(
            'Are you sure you want to clear all classes from cart list'),
        actions: [
          CupertinoDialogAction(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
              CartManager.deleteAll(_cartList
                  .map(
                    (e) => e.classId,
                  )
                  .toList());
              getAllItemsFromCart();
            },
          ),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;
  final VoidCallback onBook;
  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.onRemove,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cartItem.typeOfClass ?? 'Class Type',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  cartItem.priceOfClass ?? '0.00',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${cartItem.dateOfClass}',
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Teacher: ${cartItem.teacher}',
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Location: ${cartItem.locationOfClass ?? 'Not specified'}',
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Description: ',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Text(
                  cartItem.descriptionOfClass ?? 'No description available',
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onRemove,
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      'Remove',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                      style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: onBook,
                      child: const Text('Book')),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
