import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}
class ShopLoginInitialState extends ShopStates{}
class ShopLoginLoadingState extends ShopStates{}
class ShopLoginSuccessState extends ShopStates{
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShopStates{
  final String error ;
  ShopLoginErrorState(this.error);
}
class ShopChangeLoginSuffixState extends ShopStates{}
