// ignore_for_file: camel_case_types, avoid_print
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_3/layout/newsApp/cubit/newsState.dart';
import 'package:flutter_application_3/module/business/businessScreen.dart';
import 'package:flutter_application_3/module/science/scienceScreen.dart';
import 'package:flutter_application_3/module/sports/sportScreen.dart';
import 'package:flutter_application_3/shared/network/local/cache_helper.dart';
import 'package:flutter_application_3/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../module/settings/setting.dart';

class newsAppCubit extends Cubit<newsAppState> {
  newsAppCubit() : super(newsAppInitialState());
  static newsAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Setting',
    ),
  ];
  List<Widget> Screens = [
    businessScreen(),
    sportsScreen(),
    scienceScreen(),
    settingScreen(),
  ];
  void BottomNavBar(index) {
    currentIndex = index;

    emit(BottomNavBarState());

    if (index == 0) {
      getBusinessData();
    } else if (index == 1) {
      getSportsData();
    } else if (index == 2) {
      getScienceData();
    }
  }

  List<dynamic> business = [];
  void getBusinessData() {
    emit(newsGetBusinessLoadingData());
    if (business.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '9d82b80965e04329b4ae843d3a06cbc7'
      }).then((value) {
        business = value.data['articles'];

        print(business[0]['title']);
        emit(newsGetBusinessSuccesssData());
      }).catchError((error) {
        print(error.toString());
        emit(newsGetBusinessLErorData(error.toString()));
      });
    } else {
      emit(newsGetBusinessSuccesssData());
    }
  }

  List<dynamic> sports = [];
  void getSportsData() {
    emit(newsGetSportsLoadingData());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '9d82b80965e04329b4ae843d3a06cbc7'
      }).then((value) {
        sports = value.data['articles'];

        //print(sports[0]['title']);
        emit(newsGetSportsSuccesssData());
      }).catchError((error) {
        print(error.toString());
        emit(newsGetSportsLErorData(error.toString()));
      });
    } else {
      emit(newsGetSportsSuccesssData());
    }
  }

  List<dynamic> science = [];
  void getScienceData() {
    emit(newsGetScienceLoadingData());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '9d82b80965e04329b4ae843d3a06cbc7'
      }).then((value) {
        science = value.data['articles'];

        //print(sports[0]['title']);
        emit(newsGetScienceSuccesssData());
      }).catchError((error) {
        print(error.toString());

        emit(newsGetScienceLErorData(error.toString()));
      });
    } else {
      emit(newsGetScienceSuccesssData());
    }
  }

  bool isDark = false;
  void appThemeChange({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(newsAppthemeChange());
    } else {
      isDark = !isDark;

      cachHelper.putData(key: 'isDark', value: isDark).then(
        (value) {
          emit(newsAppthemeChange());
        },
      );
    }
  }

  List<dynamic> search = [];
  void searchData({
    required String key,
  }) {
    search = [];
    emit(newsSearchLoadingData());

    DioHelper.getData(
            url: 'v2/everything',
            query: {'q': '$key', 'apiKey': '9d82b80965e04329b4ae843d3a06cbc7'})
        .then((value) {
      search = value.data['articles'];

      emit(newsSearchSuccesssData());
    }).catchError((error) {
      print(error.toString());

      emit(newsSearchLErorData(error.toString()));
    });
  }
}
