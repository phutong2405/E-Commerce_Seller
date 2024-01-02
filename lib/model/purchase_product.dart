import 'dart:math';
import 'package:ecom_seller_1512/model/product_model.dart';

enum Progress {
  completed,
  cancel,
  inDelivery,
  inCart,
}

class Purchase {
  final Product product;
  final int amount;
  final double price;
  final double total;
  final String buyerId;
  Progress progress;

  Purchase(
      {required this.product,
      required this.amount,
      required this.price,
      // required this.buyerId,
      required this.progress})
      : total = price * amount,
        buyerId = "asd ${Random().nextInt(10)}";

  void placeOrder() {
    progress = Progress.inDelivery;
  }
}
