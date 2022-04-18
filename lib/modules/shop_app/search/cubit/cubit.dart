import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl/models/shop_app/search_model.dart';
import 'package:pl/modules/shop_app/search/cubit/states.dart';
import 'package:pl/shared/components/constants.dart';
import 'package:pl/shared/network/end_points.dart';
import 'package:pl/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'pro_name': text
        }
    )
        .then((value) {
          model = SearchModel.fromJson(value.data);
          print("HERE");
          emit(SearchSuccessState());

    })
        .catchError((error){
          print(error.toString());
          emit(SearchErrorState());
    });
  }

}