import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';


void navigateAndEnd(context,Widget widget){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);
}

void navigateTo(context,Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget),);
}

void showToast({required String message, required toastStates state}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum toastStates{SUCCESS, ERROR , WARNING}

Color toastColor(toastStates state){
  Color color ;
  switch (state){
    case toastStates.SUCCESS:
      color = Colors.green;
    break;
    case toastStates.ERROR:
      color = Colors.red;
      break;
    case toastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget defaultFormField({
  required String text ,
  isPassword = false,
  required TextEditingController controller,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  required Function? validate,
  Function? onSubmit,
  required TextInputType type ,

}){
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    onFieldSubmitted: (value){
      return onSubmit!(value);
    },
    validator:(value){
      return validate!(value);
    },
    keyboardType: type,
    decoration: InputDecoration(
      labelText: text,
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(onPressed: (){return suffixPressed!();}, icon: Icon(suffix)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
    ),
  );
}

Widget buildListItem(model, context, {bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120.0,
              height: 120.0,

            ),
            if (model.discount != 0 && isOldPrice)
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0,left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 34.0,
                  width: double.infinity,
                  child: Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(color: defaultColor, fontSize: 16.0),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 12.0),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context)
                            .changeFavorites(model.id);
                      },
                      icon: Icon(

                        ShopCubit.get(context)
                            .favorites[model.id]! && ShopCubit.get(context).favorites[model.id] ==true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: ShopCubit.get(context)
                            .favorites[model.id]! && ShopCubit.get(context).favorites[model.id] ==true
                            ? Colors.red
                            : Colors.grey,
                        size: 26.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);
