import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/login_cubit/shop_login_cubit.dart';
import 'package:shop_app/modules/login_screen/login_cubit/shop_login_states.dart';
import 'package:shop_app/modules/register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status){
              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value) {
                token = state.loginModel.data!.token;
                print('loginToken: $token');
                navigateAndEnd(context, ShopLayout());
              });
            }else{
              showToast(message: ShopLoginCubit.get(context).loginModel!.message!, state: toastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login into your account',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            text: 'Email Address',
                            controller: emailController,
                            prefix: Icons.email_outlined,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'email address must not be empty';
                              }
                            },
                            type: TextInputType.emailAddress),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            isPassword: cubit.isPassword,
                            text: 'Password',
                            controller: passwordController,
                            prefix: Icons.lock,
                            suffix: cubit.suffix,
                            suffixPressed: () {
                              cubit.changeSuffix();
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'password must not be empty';
                              }
                            },
                            onSubmit: (String value) {
                              if (formkey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            type: TextInputType.visiblePassword),
                        SizedBox(
                          height: 15.0,
                        ),
                        Conditional.single(
                          context: context,
                          fallbackBuilder: (BuildContext context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          conditionBuilder: (BuildContext context) =>
                              state is! ShopLoginLoadingState,
                          widgetBuilder: (BuildContext context) => Container(
                            height: 50.0,
                            width: double.infinity,
                            child: MaterialButton(
                              color: Colors.blue,
                              onPressed: (){
                                if (formkey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  // ShopCubit()..getHomeData()..getCategoriesData()..getUserData()..getFavoritesData()..changeBottomNav(0);
                                }
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                child: Text('Register now'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
