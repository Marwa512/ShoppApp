// ignore_for_file: non_constant_identifier_names, avoid_print, unused_element

import 'package:flutter_application_3/model/search_model.dart';
import 'package:flutter_application_3/shared/component/component/constant/constant.dart';
import 'package:flutter_application_3/shared/network/endpoints.dart';
import 'package:flutter_application_3/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class ShopSearchCubit extends Cubit<ShopSearchState> {
  ShopSearchCubit() : super(ShopSearchInitialState());
  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? search;
  void searchData({
    required String text,
  }) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(url: SEARCH, token: token, data: {
      'text': text,
    }).then((value) {
      search = SearchModel.fromJson(value.data);
      emit(ShopSearchSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}
