import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates {}
class ShopChangeBottomNavState extends ShopStates {}
class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}
class ShopLoadingCategoriesState extends ShopStates {}
class ShopSuccessCategoriesState extends ShopStates {}
class ShopErrorCategoriesState extends ShopStates {}
class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}
class ShopChangeFavoritesState extends ShopStates {}
class ShopErrorChangeFavoritesState extends ShopStates {}
class ShopLoadingFavoritesState extends ShopStates {}
class ShopSuccessFavoritesState extends ShopStates {}
class ShopErrorFavoritesState extends ShopStates {}
class ShopLoadingUserDataState extends ShopStates {}
class ShopSuccessUserDataState extends ShopStates {}
class ShopErrorUserDataState extends ShopStates {}
class ShopLoadingUpdateUserState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopLoadingUpdateUserState(this.loginModel);
}
class ShopSuccessUpdateUserState extends ShopStates {}
class ShopErrorUpdateUserState extends ShopStates {}
