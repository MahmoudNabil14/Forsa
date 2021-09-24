import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';

import 'package:shop_app/modules/login_screen/login_cubit/shop_login_cubit.dart';
import 'package:shop_app/modules/login_screen/login_cubit/shop_login_states.dart';
import 'package:shop_app/modules/register_screen/register_cubit/shop_register_cubit.dart';
import 'package:shop_app/modules/register_screen/register_cubit/shop_register_states.dart';
import 'package:shop_app/modules/register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                ShopCubit.get(context).changeBottomNav(0);
                navigateAndEnd(context, ShopLayout());
              });
            } else {
              showToast(
                  message: state.loginModel.message!, state: toastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register your account',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            text: 'Name',
                            controller: nameController,
                            prefix: Icons.person,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your name';
                              }
                            },
                            type: TextInputType.name),
                        SizedBox(
                          height: 15.0,
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
                            type: TextInputType.visiblePassword),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            text: 'Phone',
                            controller: phoneController,
                            prefix: Icons.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your phone';
                              }
                            },
                            type: TextInputType.phone),
                        SizedBox(
                          height: 15.0,
                        ),
                        Conditional.single(
                          context: context,
                          fallbackBuilder: (BuildContext context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          conditionBuilder: (BuildContext context) =>
                              state is! ShopRegisterLoadingState,
                          widgetBuilder: (BuildContext context) => Container(
                            height: 50.0,
                            width: double.infinity,
                            child: MaterialButton(
                              color: Colors.blue,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text
                                  );
                                }
                              },
                              child: Text(
                                "Register".toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
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
