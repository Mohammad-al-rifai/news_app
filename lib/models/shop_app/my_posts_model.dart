class MyPostsModel {
  bool success;
  List<dynamic> data = [];
  String message;

  MyPostsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
      json['data'].forEach((v) {
        data.add(v);
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
  String price;
  int countOfLikes;
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
    countOfLikes = json['countOfLikes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}


