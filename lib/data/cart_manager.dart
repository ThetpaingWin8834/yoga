import 'package:hive_flutter/adapters.dart';

import '../main.dart';
import '../models/cart_item.dart';

class CartManager {
  CartManager._();
  static List<CartItem> getAllCartItems() {
    final box = Hive.box<CartItem>(cartBoxName);
    return box.values.toList();
  }

  static CartItem? getCartItem(int id) {
    final box = Hive.box<CartItem>(cartBoxName);
    return box.get(id);
  }

  static Future<void> addCartItem(CartItem cartItem) async {
    final box = Hive.box<CartItem>(cartBoxName);
    return await box.put(cartItem.classId, cartItem);
  }

  static Future<void> removeCartItem(int id) async {
    final box = Hive.box<CartItem>(cartBoxName);
    return await box.delete(id);
  }

  static Future<void> deleteAll(String id) async {
    final box = Hive.box<CartItem>(cartBoxName);
    return await box.deleteAll(box.values.map(
      (e) => e.classId,
    ));
  }
}
