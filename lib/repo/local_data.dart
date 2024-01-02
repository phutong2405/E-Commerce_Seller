import 'package:ecom_seller_1512/model/product_model.dart';
import 'package:ecom_seller_1512/model/purchase_product.dart';

enum LocalDataType {
  purchase,
  accountSettings,
  appSettings,
  favoritedProducts,
  savedProducts
}

List<Product> favList = [];
List<Product> saveList = [];

class LocalData {
  late final List<Purchase> _purchaseList;
  late final List<Product> _favoritedProducts;
  late final List<Product> _savedProducts;
  late final List<Product> _appSettings;
  late final List<Product> _accountSettings;
  LocalData._sharedInstance();
  static final LocalData _shared = LocalData._sharedInstance();
  factory LocalData.instance() => _shared;

  void initial() {
    _purchaseList = [];
    _appSettings = [];
    _favoritedProducts = [];
    _savedProducts = [];
  }

  List<Purchase> getProgressPurchase({required Progress progress}) {
    return _purchaseList
        .where((element) => element.progress == progress)
        .toList();
  }

  List<Product> getProgressProduct({Progress? progress}) {
    if (progress != null) {
      return _purchaseList
          .where((element) => element.progress == progress)
          .toList()
          .map((e) => e.product)
          .toList();
    } else {
      return _purchaseList.map((e) => e.product).toList();
    }
  }

  dynamic getData({required LocalDataType dataType}) {
    switch (dataType) {
      case LocalDataType.accountSettings:
        return _accountSettings;
      case LocalDataType.appSettings:
        return _appSettings;
      case LocalDataType.purchase:
        return _purchaseList;
      case LocalDataType.favoritedProducts:
        return _favoritedProducts;
      case LocalDataType.savedProducts:
        return _savedProducts;
    }
  }

  void addData({required LocalDataType dataType, required Product product}) {
    switch (dataType) {
      case LocalDataType.purchase:
        Purchase purchase = Purchase(
          product: product,
          amount: 1,
          price: double.parse(product.sellingPrice),
          progress: Progress.inCart,
        );
        _purchaseList.add(purchase);
      case LocalDataType.appSettings:
        _appSettings.add(product);
      case LocalDataType.accountSettings:
        _accountSettings.add(product);
      case LocalDataType.favoritedProducts:
        _favoritedProducts.add(product);
      case LocalDataType.savedProducts:
        _savedProducts.add(product);
    }
  }

  void removeData({required LocalDataType dataType, required Product product}) {
    switch (dataType) {
      case LocalDataType.purchase:
        _purchaseList.removeWhere((element) => element.product == product);
      case LocalDataType.appSettings:
        _appSettings.remove(product);
      case LocalDataType.accountSettings:
        _accountSettings.remove(product);
      case LocalDataType.favoritedProducts:
        _favoritedProducts.remove(product);
      case LocalDataType.savedProducts:
        _savedProducts.remove(product);
    }
  }

  void updateProgress(
      {required Progress fromProgress,
      required Progress toProgress,
      required List<Purchase> purchaseList}) {
    _purchaseList.removeWhere((element) => purchaseList.contains(element));

    for (var element in purchaseList) {
      element.placeOrder();
      _purchaseList.add(element);
    }
  }
}
