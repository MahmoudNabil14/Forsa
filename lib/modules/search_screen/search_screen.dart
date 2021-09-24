import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search_screen/search_cubit/shop_search_cubit.dart';
import 'package:shop_app/modules/search_screen/search_cubit/shop_search_states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        text: 'Search',
                        controller: searchController,
                        prefix: Icons.search,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Please enter text to search';
                          }
                          return null;
                        },
                        onSubmit: (String text){
                          SearchCubit.get(context).search(searchController.text);
                        },
                        type: TextInputType.text
                    ),
                    SizedBox(height: 15.0,),

                    if(state is ShopLoadingSearchState)
                      LinearProgressIndicator(),

                    SizedBox(height: 10.0,),

                    if(state is ShopSuccessSearchState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListItem(
                            SearchCubit.get(context).searchModel!.data.data[index],
                            context,
                            isOldPrice: false),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 1.0,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                        ),
                        itemCount: SearchCubit.get(context).searchModel!.data.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
