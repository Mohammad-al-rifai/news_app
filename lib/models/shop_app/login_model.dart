class ShopLoginModel
{
  bool status;
  UserData data;
  String message;


  ShopLoginModel.fromJson(Map<String,dynamic> json)
  {
    status = json['success'];
    data = UserData.fromJson(json['data']);
    message = json['message'];
  }
}

class UserData
{
  String token;
  String name;
  String phone;
  String email;
  int userId;


  // Named Constructor

  UserData.fromJson(Map<String , dynamic> json){
    token = json['token'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    userId = json['id'];
  }
}