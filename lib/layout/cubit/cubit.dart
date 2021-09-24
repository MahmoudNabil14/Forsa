import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories_screen.dart';
import 'package:shop_app/modules/favorites_screen.dart';
import 'package:shop_app/modules/products_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/shared/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  bool shimmerEnable = false;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: HOME,
        token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id!: element.in_favorites!});
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(url: CATEGORIES,token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE,token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
}) {
    emit(ShopLoadingUpdateUserState(userModel!));
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          "name": name,
          "email":email,
          "phone":phone,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(url: FAVORITES,token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavoritesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());
    DioHelper.postData(
            url: FAVORITES,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel!.status == false ) {
        favorites[productId] = !favorites[productId]!;
      }
      else{
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
      print(error.toString());
    });
  }
}
