// ignore_for_file: non_constant_identifier_names, avoid_print, unused_element

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/layout/shop_layout/cubit/states.dart';
import 'package:flutter_application_3/model/Categories_model.dart';
import 'package:flutter_application_3/model/HomeModel.dart';
import 'package:flutter_application_3/model/cart_model.dart';
import 'package:flutter_application_3/model/cart_model.dart';
import 'package:flutter_application_3/model/change_cart.dart';
import 'package:flutter_application_3/model/change_favorite_model.dart';
import 'package:flutter_application_3/model/get_favorites_model.dart';
import 'package:flutter_application_3/model/shoploginmodel.dart';
import 'package:flutter_application_3/module/ShopApp/categories/CategoriesScreen.dart';
import 'package:flutter_application_3/module/ShopApp/favorites/FavoritesScreen.dart';
import 'package:flutter_application_3/module/ShopApp/products/ProductScreen.dart';
import 'package:flutter_application_3/module/ShopApp/setting/SettingScreen.dart';
import 'package:flutter_application_3/shared/component/component/constant/constant.dart';
import 'package:flutter_application_3/shared/network/endpoints.dart';
import 'package:flutter_application_3/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/HomeModel.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
    //const CategoriesScreen()
  ];

  void BottomNavBar(index) {
    currentIndex = index;

    emit(ShopBottomNavBarState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  Map<int, bool> cart = {};

  void getHomeData() {
    emit(ShopLoadingProductsState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromjson(value.data);
      /*  print(homeModel!.status);

      print(homeModel!.data!.products[5].name); */
      homeModel!.data!.products.forEach(((element) {
        favorites.addAll({element.id: element.inFavorites});
        cart.addAll({element.id: element.inCart});
        //print(favorites.toString());
      }));
      emit(ShopSuccessProductState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorProductState());
    });
  }

  late CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritsModel? changeFav;
  void changeFavorite({required int productID}) {
    favorites[productID] = !favorites[productID]!;
    emit(ShopFavProductState());

    DioHelper.postData(
            url: FAVORITE, data: {'product_id': productID}, token: token)
        .then((value) {
      print(value.data);

      changeFav = ChangeFavoritsModel.fromJson(value.data);
      if (!changeFav!.status) {
        favorites[productID] = !favorites[productID]!;
      } else {
        getCFavData();
      }
      emit(ShopSuccessFavtProductState(changeFav!));
    }).catchError((error) {
      favorites[productID] = !favorites[productID]!;

      print(error.toString());
      emit(ShopErrorFavtProductState());
    });
  }

  late FavoritesModel favoritesModel;

  void getCFavData() {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(url: FAVORITE, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() async {
    emit(ShopLoadingUserDataState());
    await DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      print(' Error  ${error.toString()}');
      emit(ShopErrorUserDataState());
    });
  }

  ShopLoginModel? updateModel;

  void updateUserData({
    required String email,
    required String name,
    required String phone,
  }) async {
    emit(ShopLoadingUpdateUserDataState());
    await DioHelper.putData(url: UPDATE_USER, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      updateModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState());
    }).catchError((error) {
      print(' Error  ${error.toString()}');
      emit(ShopErrorUpdateUserDataState());
    });
  }

  ChangeCartModel? changeCart;
  void putInCart({required int productID}) {
    cart[productID] = !cart[productID]!;
    emit(ShopCartState());

    DioHelper.postData(url: CART, data: {'product_id': productID}, token: token)
        .then((value) {
      print(value.data);

      changeCart = ChangeCartModel.fromJson(value.data);
      if (!changeCart!.status) {
        cart[productID] = !cart[productID]!;
      } else {
        getCartData();
      }
      emit(ShopSuccessCartProductState(changeCart!));
    }).catchError((error) {
      cart[productID] = !cart[productID]!;

      print(error.toString());
      emit(ShopErrorCartProductState());
    });
  }

  late CartModel cartModel;

  void getCartData() {
    emit(ShopLoadingCartState());
    DioHelper.getData(url: CART, token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(ShopSuccessCartState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCartState());
    });
  }
}
