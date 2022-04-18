class DetailsModel {
  bool success;
  Data data;
  String message;

  DetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Data.fromJson(json['data']);
    message = json['message'];
  }
}

class Data {
  int id;
  int views;
  int userId;
  int commentsCount;
  int likesCount;
  int thePriceAfterDiscount;
  List<dynamic> comments = [];

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    views = json['views'];
    userId = json['user_id'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    thePriceAfterDiscount = json['The_Price_After_Discount'];
    json['comments'].forEach((v) {
      comments.add(v);
    });

  }
}

class Comments {
  int id;
  int productId;
  int userId;
  String userName;
  String comment;
  String createdAt;
  String updatedAt;

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
