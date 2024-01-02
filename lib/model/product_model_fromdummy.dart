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
  String pid;
  List<Map<String, String>> productDetails;
  String seller;
  String sellingPrice;
  String subCategory;
  String title;
  String url;

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
    required this.pid,
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
      actualPrice: ((json['price'] / (100 - json['discountPercentage'])) * 100)
          .toString(),
      averageRating: json['rating'].toString(),
      brand: json['brand'],
      category: json['category'],
      crawledAt: '',
      description: json['description'],
      discount: json['discountPercentage'].toString(),
      images: List<String>.from(json['images']),
      outOfStock: false,
      pid: json['stock'].toString(),
      productDetails: [],
      seller: '',
      sellingPrice: json['price'].toString(),
      subCategory: '',
      title: json['title'],
      url: json['thumbnail'],
    );
  }

  @override
  bool operator ==(covariant Product other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}
