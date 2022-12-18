// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/shoploginmodel.dart';
import 'package:flutter_application_3/module/ShopApp/login/cubit/states.dart';
import 'package:flutter_application_3/shared/component/component/constant/constant.dart';
import 'package:flutter_application_3/shared/network/endpoints.dart';
import 'package:flutter_application_3/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<shopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      // message = value.data['message'];
      loginModel = ShopLoginModel.fromJson(value.data);
      token = loginModel.data!.token!;
      print(loginModel.message);
      print("Token");
      print(loginModel.data!.token);

      emit(ShopLoginSucessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changePasswordVisibility() {
    if (isPasswordShown == true) {
      suffix = Icons.visibility_off_outlined;
      isPasswordShown = false;
    } else {
      suffix = Icons.visibility_outlined;
      isPasswordShown = true;
    }

    emit(ShopLoginchangePasswordVisibilityState());
  }
}
