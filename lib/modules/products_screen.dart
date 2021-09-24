import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status!){
            showToast(message: state.model.message!, state: toastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return Conditional.single(
          conditionBuilder: (context) => ShopCubit.get(context).homeModel != null&& ShopCubit.get(context).categoriesModel !=null ,
          widgetBuilder:(context) => productBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
            fallbackBuilder:(context)=> Center(child: CircularProgressIndicator(),),
            context: context);
      },

    );
  }

  Widget productBuilder(HomeModel? model,CategoriesModel? categoriesModel,context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: model!.data.banners
                    .map((e) => Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Image(
                              image: NetworkImage(
                                '${e.image}',
                              ),
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0,)
                      ],
                    ),
                ).toList(),
                options: CarouselOptions(
                  height: 170.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 6),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  reverse: false,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 0.7,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  color: Colors.blue,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Categories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0,left: 7.0,right: 7.0,bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration( color: Colors.grey[300],borderRadius: BorderRadius.circular(15.0)),
                      height: 100.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index) => buildCategories(categoriesModel!.data.model[index]),
                            separatorBuilder:(context,index) => SizedBox(width: 5.0),
                            itemCount: categoriesModel!.data.model.length),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('New Products',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 1 / 1.6,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(model.data.products.length,
                        (index) => buildGridProduct(model.data.products[index],context)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget buildGridProduct(model,context) => Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 34.0,
                  width: double.infinity,
                  child: Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(color: defaultColor, fontSize: 16.0),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.old_price.round()}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 12.0),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id!);
                      },
                      icon: Icon(ShopCubit.get(context).favorites[model.id]! ? Icons.favorite:Icons.favorite_border,
                      color: ShopCubit.get(context).favorites[model.id]! ? Colors.red : Colors.grey,

                        size: 26.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ));

  Widget buildCategories(DataModel model) => Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0),
      color: Colors.white,
    ),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
            image: NetworkImage(model.image),
          width: 100.0,
          height: 100.0,
        ),
        Container(
          width: 100.0,
          color: Colors.black.withOpacity(0.6),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white
              ),
            ),
          ),
        )
      ],
    ),
  );
}


