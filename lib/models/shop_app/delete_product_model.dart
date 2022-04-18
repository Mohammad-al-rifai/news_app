class DelProModel {
  bool success;
  String message;


  DelProModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}
