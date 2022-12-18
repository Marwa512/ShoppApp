class ChangeFavoritsModel {
  late bool status;
  late String message;
  ChangeFavoritsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
