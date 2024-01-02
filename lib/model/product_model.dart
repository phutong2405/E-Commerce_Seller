class Product {
  String id;
  String actualPrice;
  String averageRating;
  String brand;
  String category;
  String crawledAt;
  String description;
  String discount;
  List<String> images;
  bool outOfStock;
  String stock;
  List<Map<String, String>> productDetails;
  String seller;
  String sellingPrice;
  String subCategory;
  String title;
  String url;
  bool isFavorited = false;
  bool isSaved = false;

  Product({
    required this.id,
    required this.actualPrice,
    required this.averageRating,
    required this.brand,
    required this.category,
    required this.crawledAt,
    required this.description,
    required this.discount,
    required this.images,
    required this.outOfStock,
    required this.stock,
    required this.productDetails,
    required this.seller,
    required this.sellingPrice,
    required this.subCategory,
    required this.title,
    required this.url,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      actualPrice: ((json['price'] +
              (json['price'] * json['discountPercentage']) / 100) as double)
          .round()
          .toString(),
      averageRating: json['rating'].toString(),
      brand: json['brand'],
      category: json['category'],
      crawledAt: '',
      description: json['description'],
      discount: json['discountPercentage'].toString(),
      images: List<String>.from(json['images']),
      outOfStock: false,
      stock: json['stock'].toString(),
      productDetails: [],
      seller: '',
      sellingPrice: json['price'].toString(),
      subCategory: '',
      title: json['title'],
      url: json['thumbnail'],
    );
  }

  void toggleFavorite({required bool isFavorited}) {
    this.isFavorited = isFavorited;
  }

  void toggleSave({required bool value}) {
    isSaved = value;
  }

  @override
  bool operator ==(covariant Product other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}
