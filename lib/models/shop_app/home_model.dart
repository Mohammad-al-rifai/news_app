class HomeModel {
  bool success;
  List<dynamic> products = [];
  String message;

  HomeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    json['data'].forEach((v) {
        products.add(v);
    });

    message = json['message'];
  }
}

class Data {
  int id;
  int views;
  int userId;
  String proName;
  String title;
  String url;
  String proExpirationDate;
  String proCategory;
  String proPhone;
  String proQuantity;
  double price;
  List<dynamic> discounts;
  Null countOfLikes;
  String createdAt;
  String updatedAt;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    views = json['views'];
    userId = json['user_id'];
    proName = json['pro_name'];
    title = json['title'];
    url = json['url'];
    proExpirationDate = json['pro_expiration_Date'];
    proCategory = json['pro_Category'];
    proPhone = json['pro_phone'];
    proQuantity = json['pro_quantity'];
    price = json['price'];
    json['discounts'].forEach((v) {
      discounts.add(v);
    });
    countOfLikes = json['countOfLikes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Discounts {
  int id;
  int productId;
  String discountPercentage;
  String date;
  String createdAt;
  String updatedAt;


  Discounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    discountPercentage = json['discount_percentage'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
