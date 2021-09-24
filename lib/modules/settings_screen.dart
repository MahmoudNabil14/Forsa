import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login_screen/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = ShopCubit.get(context).userModel!.data!.name;
        emailController.text = ShopCubit.get(context).userModel!.data!.email;
        phoneController.text = ShopCubit.get(context).userModel!.data!.phone;

        return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                ShopCubit.get(context).userModel != null,
            widgetBuilder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if(state is ShopLoadingUpdateUserState)
                            LinearProgressIndicator(),
                          SizedBox(height: 20.0,),
                          defaultFormField(
                            type: TextInputType.name,
                            controller: nameController,
                            prefix: Icons.person,
                            text: 'Name',
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Name must not be empty';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            prefix: Icons.email,
                            text: 'Email Address',
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Email Address must not be empty';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            type: TextInputType.phone,
                            controller: phoneController,
                            prefix: Icons.phone,
                            text: 'Phone',
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Phone must not be empty';
                              }
                            },
                          ),

                          SizedBox(
                            height: 20.0,
                          ),

                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              color: defaultColor,
                            ),
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopCubit.get(context).updateUserData(name: nameController.text,email: emailController.text, phone: phoneController.text);
                                }
                              },
                              child: Text('Update',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20.0,
                          ),

                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              color: defaultColor,
                            ),
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () {
                                CacheHelper.removeData(key: 'token').then((value) {
                                  if(value){
                                    navigateAndEnd(context, ShopLoginScreen());
                                  }
                                });
                              },
                              child: Text('Sign Out',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            fallbackBuilder: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}
