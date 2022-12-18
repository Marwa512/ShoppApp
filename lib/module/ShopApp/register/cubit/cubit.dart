// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_application_3/model/shoploginmodel.dart';
import 'package:flutter_application_3/module/ShopApp/register/cubit/states.dart';

import 'package:flutter_application_3/shared/component/component/constant/constant.dart';
import 'package:flutter_application_3/shared/network/endpoints.dart';
import 'package:flutter_application_3/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<shopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      // message = value.data['message'];
      loginModel = ShopLoginModel.fromJson(value.data);
      token = loginModel.data!.token!;

      emit(ShopRegisterSucessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
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

    emit(ShopRegisterchangePasswordVisibilityState());
  }
}
