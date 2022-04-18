
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl/models/shop_app/login_model.dart';
import 'package:pl/modules/shop_app/register/cubit/states.dart';
import 'package:pl/shared/network/end_points.dart';
import 'package:pl/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userRegister({
  @required String name,
  @required String email,
  @required String password,
  @required String phone,
})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data:
        {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'C_password': password
        },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);  //decode The Json Data Is Success!✔️
       emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassWord = true;

  void changeVisibility(){
    isPassWord = !isPassWord;
    suffix =isPassWord? Icons.visibility_outlined :Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}