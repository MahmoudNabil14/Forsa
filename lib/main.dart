import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/shop_login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/shared/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/shop_on_boarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  var onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  late Widget widget;
  print(token);
  if(onBoarding != null){
    if(token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();

  }else{
    widget = OnBoardingScreen();
  }
  runApp(MyApp(onBoarding: onBoarding, startWidget: widget,));
}

class MyApp extends StatelessWidget {

  final onBoarding;
  final Widget startWidget;
  MyApp({required this.onBoarding, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Forsa',
        themeMode: ThemeMode.light,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startWidget,
      ),
    );
  }
}
