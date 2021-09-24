import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {},
      builder: (context,state){
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
            itemBuilder: (context,index)=>categoryItem(ShopCubit.get(context).categoriesModel!.data.model[index]),
            separatorBuilder:(context,index)=> Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.black,
            ),
            itemCount: ShopCubit.get(context).categoriesModel!.data.model.length);
      },
    );
  }

  Widget categoryItem(DataModel model) => Column(
    children: [
      SizedBox(height: 10.0,),
      Row(
        children: [
          Image(
              image: NetworkImage(model.image
          ),
            width: 100.0,
            height: 100.0,
          ),
          SizedBox(width: 20.0,),
          Text(
              model.name,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
      SizedBox(height: 10.0,)
    ],
  );
}
