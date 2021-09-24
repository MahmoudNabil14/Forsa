import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  state is! ShopLoadingFavoritesState,
              widgetBuilder: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildListItem(
                        ShopCubit.get(context).favoritesModel!.data.data[index].product,
                        context),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 1.0,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                    ),
                    itemCount:
                        ShopCubit.get(context).favoritesModel!.data.data.length,
                  ),
              fallbackBuilder: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }

}
