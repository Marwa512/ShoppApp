// ignore_for_file: camel_case_types

import 'package:flutter_application_3/model/shoploginmodel.dart';

abstract class shopLoginStates {
  var loginModel;
}

class ShopLoginInitialState extends shopLoginStates {}

class ShopLoginLoadingState extends shopLoginStates {}

class ShopLoginSucessState extends shopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSucessState(this.loginModel);
}

class ShopLoginErrorState extends shopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginchangePasswordVisibilityState extends shopLoginStates {}
