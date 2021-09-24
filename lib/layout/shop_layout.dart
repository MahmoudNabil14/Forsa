import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Forsa'),
            actions: [
              IconButton(onPressed: (){navigateTo(context, SearchScreen());}, icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Products'),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
          ],

          ),
        );
      },

    );
  }
}
