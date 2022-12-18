import 'package:flutter_application_3/model/change_cart.dart';
import 'package:flutter_application_3/model/change_favorite_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopBottomNavBarState extends ShopStates {}

class ShopLoadingProductsState extends ShopStates {}

class ShopSuccessProductState extends ShopStates {}

class ShopErrorProductState extends ShopStates {}

class ShopFavProductState extends ShopStates {}

class ShopSuccessFavtProductState extends ShopStates {
  final ChangeFavoritsModel model;
  ShopSuccessFavtProductState(this.model);
}

class ShopErrorFavtProductState extends ShopStates {}

class ShopLoadingCategoriesState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessFavoritesState extends ShopStates {}

class ShopErrorFavoritesState extends ShopStates {}

class ShopLoadingFavoritesState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {}

class ShopErrorUpdateUserDataState extends ShopStates {}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessCartState extends ShopStates {}

class ShopErrorCartState extends ShopStates {}

class ShopLoadingCartState extends ShopStates {}

class ShopSuccessCartProductState extends ShopStates {
  final ChangeCartModel model;
  ShopSuccessCartProductState(this.model);
}

class ShopErrorCartProductState extends ShopStates {}

class ShopCartState extends ShopStates {}
