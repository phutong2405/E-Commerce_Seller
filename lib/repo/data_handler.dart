import 'package:ecom_seller_1512/model/dummy_data.dart';
import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collection/collection.dart';

enum DashboardType {
  remains,
  orders,
  revenue,
  outOfStock,
}

enum TypeName {
  product,
  cash,
  amount,
}

class DataHandler {
  DataHandler._sharedInstance();
  static final DataHandler _shared = DataHandler._sharedInstance();
  factory DataHandler.instance() => _shared;

  Map<String, List<Product>> filterProduct({
    required List<Product> productData,
  }) {
    Map<String, List<Product>> tmp = {};
    for (var element in filters) {
      tmp[element] =
          productData.where((product) => product.category == element).toList();
    }
    return tmp;
  }

  Map<DashboardType, List<Product>> typedProduct({
    required List<Product> productData,
  }) {
    Map<DashboardType, List<Product>> dashboardTypeData = {
      DashboardType.remains: [],
      DashboardType.orders: [],
      DashboardType.outOfStock: [],
      DashboardType.revenue: [],
    };
    dashboardTypeData[DashboardType.remains] =
        productData.where((element) => int.parse(element.stock) > 0).toList();

    dashboardTypeData[DashboardType.outOfStock] =
        productData.where((element) => int.parse(element.stock) == 0).toList();

    return dashboardTypeData;
  }

  Map<DashboardType, int> countingTypeProduct({
    required Map<DashboardType, List<Product>> typedProductList,
  }) {
    Map<DashboardType, int> dashboardTypeData = {
      DashboardType.remains: 0,
      DashboardType.orders: 0,
      DashboardType.outOfStock: 0,
      DashboardType.revenue: 0,
    };
    dashboardTypeData[DashboardType.remains] =
        typedProductList[DashboardType.remains]!.fold(
      0,
      (previousValue, element) =>
          previousValue +
          int.parse(
            element.stock,
          ),
    );

    dashboardTypeData[DashboardType.outOfStock] =
        typedProductList[DashboardType.outOfStock]!
            .where((element) => int.parse(element.stock) == 0)
            .toList()
            .length;

    dashboardTypeData[DashboardType.revenue] =
        typedProductList[DashboardType.remains]!.fold(
      0,
      (previousValue, element) =>
          previousValue +
          int.parse(
            element.sellingPrice,
          ),
    );

    return dashboardTypeData;
  }
}

String dashboardName(DashboardType type) {
  switch (type) {
    case DashboardType.remains:
      return "Remains";
    case DashboardType.orders:
      return "Orders";
    case DashboardType.outOfStock:
      return "Out of Stock";
    case DashboardType.revenue:
      return "Revenue";
    default:
      return "";
  }
}

String typeName(TypeName type) {
  switch (type) {
    case TypeName.amount:
      return "amount";
    case TypeName.cash:
      return "cash";
    case TypeName.product:
      return "product";
    default:
      return "";
  }
}

Widget titleWithSub(
    {required DashboardType dashboardType, required TypeName typeSub}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        dashboardName(dashboardType),
        style: GoogleFonts.comfortaa(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        typeName(typeSub),
        style: GoogleFonts.hind(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.grey,
        ),
      ),
    ],
  );
}
