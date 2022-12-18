// ignore_for_file: camel_case_types

import 'package:flutter_application_3/model/shoploginmodel.dart';

abstract class shopRegisterStates {
  var loginModel;
}

class ShopRegisterInitialState extends shopRegisterStates {}

class ShopRegisterLoadingState extends shopRegisterStates {}

class ShopRegisterSucessState extends shopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterSucessState(this.loginModel);
}

class ShopRegisterErrorState extends shopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterchangePasswordVisibilityState extends shopRegisterStates {}
