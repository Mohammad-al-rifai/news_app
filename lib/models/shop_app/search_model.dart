class SearchModel {
  bool success;
  String data;
  List<dynamic> message = [];

  SearchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    json['message'].forEach((v) {
        message.add(v);
    });
    }
  }

class Message {
  int id;
  int views;
  int userId;
  String proName;
  double price;
  String title;
  String url;
  String proExpirationDate;
  String proCategory;
  String proPhone;
  String proQuantity;
  int commentsCount;
  int likesCount;


  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    views = json['views'];
    userId = json['user_id'];
    proName = json['pro_name'];
    price = json['price'];
    title = json['title'];
    url = json['url'];
    proExpirationDate = json['pro_expiration_Date'];
    proCategory = json['pro_Category'];
    proPhone = json['pro_phone'];
    proQuantity = json['pro_quantity'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
  }
}
