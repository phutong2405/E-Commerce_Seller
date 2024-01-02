import 'dart:convert';
import 'package:ecom_seller_1512/model/product_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

String urlCat = 'https://dummyjson.com/products/categories';
// https://dummyjson.com/products?limit=10&skip=10

class FetchProduct {
  FetchProduct._sharedInstance();
  static final FetchProduct _shared = FetchProduct._sharedInstance();
  factory FetchProduct.instance() => _shared;

  Future<Iterable<Product>> initialFetchProduct(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      List<dynamic> data = jsonDecode(response.body)['products'];
      return data.map<Product>((e) => Product.fromJson(e));
    } catch (e) {
      return [];
    }
  }

  Future<Iterable<Product>> fetchProduct(
      {String? url, required int lengthToSkip}) async {
    try {
      final response = await http.get(Uri.parse(
          url ?? "https://dummyjson.com/products?limit=10&skip=$lengthToSkip"));
      List<dynamic> data = jsonDecode(response.body)['products'];
      return data.map<Product>((e) => Product.fromJson(e));
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> fetchCategories(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      List<String> data = jsonDecode(response.body);
      return data;
    } catch (e) {
      return [];
    }
  }
}
