class ShopLoginModel {
  late bool status;
  String? message;
  UserDataModel? data;
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    //data = (json['data'] != null ? UserDataModel.fromJson(json[data]) : null)!;
    data = json['data'] != null ? UserDataModel.fromJson(json['data']) : null;
  }
}

class UserDataModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  int? points;
  int? credit;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];

    image = json['image'];

    token = json['token'];

    points = json['points'];

    credit = json['credit'];
  }
}
