import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search_screen/search_cubit/shop_search_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/shared/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(ShopInitialSearchState());

  static SearchCubit get(context)=> BlocProvider.of(context);

  SearchModel? searchModel ;

  void search(String text){
    emit(ShopLoadingSearchState());
    DioHelper.searchData(url: SEARCH, data: {
      'text':text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorSearchState());
    });
  }
}