import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login_screen/login_cubit/shop_login_states.dart';
import 'package:shop_app/modules/register_screen/register_cubit/shop_register_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/shared/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit () : super (ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=> BlocProvider.of(context);
  bool isPassword =true ;
  IconData suffix  = Icons.visibility_outlined;
  ShopLoginModel ? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
        ).then((value) {
          loginModel = ShopLoginModel.fromJson(value.data);
          ShopCubit()..getHomeData()..getCategoriesData()..getCategoriesData()..getUserData();
          emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  void changeSuffix(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangeRegisterSuffixState());
  }
}