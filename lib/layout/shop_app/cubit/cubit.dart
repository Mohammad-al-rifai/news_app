import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pl/layout/shop_app/cubit/states.dart';
import 'package:pl/models/shop_app/delete_product_model.dart';
import 'package:pl/models/shop_app/home_model.dart';
import 'package:pl/models/shop_app/login_model.dart';
import 'package:pl/models/shop_app/my_posts_model.dart';
import 'package:pl/models/shop_app/product_details_model.dart';
import 'package:pl/models/shop_app/search_model.dart';
import 'package:pl/models/shop_app/update_product_model.dart';
import 'package:pl/modules/shop_app/my_posts/my_posts_screen.dart';
import 'package:pl/modules/shop_app/new_product/new_product_screen.dart';
import 'package:pl/modules/shop_app/products/products_screen.dart';
import 'package:pl/modules/shop_app/search/cubit/states.dart';
import 'package:pl/modules/shop_app/settings/setting_screen.dart';
import 'package:pl/shared/components/components.dart';
import 'package:pl/shared/components/constants.dart';
import 'package:pl/shared/network/end_points.dart';
import 'package:pl/shared/network/remote/dio_helper.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    NewProductScreen(),
    MyPostsScreen(),
    SettingScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print("success: ${homeModel.success}");
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  DetailsModel detailsModel;
  DetailsModel getProDetailsData(int productID) {
    emit(ShopLoadingProDetailsDataState());
    DioHelper.getData(
      url: 'product/show/$productID',
      token: token,
    ).then((value) {
      detailsModel = DetailsModel.fromJson(value.data);
      print("success: ${detailsModel.success}");
      emit(ShopSuccessProDetailsDataState(detailsModel));
      getHomeData();
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorProDetailsDataState());
    });
    return detailsModel;
  }



  ShopLoginModel userModel;


  List<Map<dynamic,dynamic>> discounts = [];

  void createNewProduct({
    @required String name,
    @required String category,
    @required String expiredDate,
    @required String phone,
    @required String quantity,
    @required String price,
    @required File url,
    @required String title,
    @required List<Map<dynamic, dynamic>> discountList,
  }) async {
    emit(ShopLoadingCreateProductState());
    DioHelper.postData(
      url: CREATE_PRODUCT,
      token: token,
      data: new FormData.fromMap({
        'pro_name': name,
        'pro_Category': category,
        'pro_expiration_Date': expiredDate,
        'pro_phone': phone,
        'pro_quantity': quantity,
        'price': price,
        'image': await MultipartFile.fromFile(url.path,),
        'title':title,
        'list_discounts': discountList
      }),
    ).then((value) {
      emit(ShopSuccessCreateProductState());
      print("One Product Created Successfully!");
      print(value.data);
      discounts = [];
      getHomeData();
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCreateProductState());
    });
  }



  void comment({
  @required int productID,
  @required String comment,
})async{
    emit(CommentLoadingState());

    DioHelper.postData(
        url: 'product/storeOfComment/$productID',
        token: token,
        data: {
          'comment':comment
        }
    )
        .then((value) {
          emit(CommentSuccessState());
          getProDetailsData(productID);
    })
        .catchError((error){
          print(error.toString());
          emit(CommentErrorState());
    });

  }


  IconData iconData = Icons.favorite_border_rounded;
  bool isLike = false;

  void changeLikeState(){
    iconData = isLike? Icons.favorite :Icons.favorite_border_rounded;
    isLike = !isLike;
    emit(ShopChangeLikeState());
  }

  void like(int productId){

    emit(LikeLoadingState());


    DioHelper.postData(
        url: 'product/storeOfLikes/$productId',
        data: {
        },
        token: token
    )
        .then((value) {
          emit(LikeSuccessState());
          changeLikeState();
          getProDetailsData(productId);
          print(value.data);
    })
        .catchError((error){
          emit(LikeErrorState());
          print(error.toString());
    });
  }






  UpdateProModel updateProModel;
  void updateProductData({
    @required int productID,
    @required String name,
    @required String category,
    @required String phone,
    @required String quantity,
    @required String price,
  })
  {
    emit(ShopLoadingUpdateProductState());
    DioHelper.putData(
      url: 'product/update/$productID',
      token: token,
      data: {
        'name':name,
        'pro_Category':category,
        'pro_phone':phone,
        'pro_quantity':quantity,
        'price':price,
      },
    ).then((value){
      updateProModel = UpdateProModel.fromJson(value.data);
      emit(ShopSuccessUpdateProductState(updateProModel));

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateProductState());
    });
  }









  DelProModel delProModel;
  void deleteProduct(int productID,BuildContext context){
    emit(ShopLoadingDeleteProductState());
    DioHelper.deleteData(
        url: 'product/destroy/$productID',
      token: token,
    )
        .then((value) async{
          delProModel = DelProModel.fromJson(value.data);
          if(delProModel.success == true){
            emit(ShopSuccessDeleteProductState());
            print("PRODUCT HAS BEEN DELETED SUCCESSFULLY!");
            showToast(text: 'PRODUCT HAS BEEN DELETED SUCCESSFULLY!', state: ToastStates.SUCCESS);
            getHomeData();
          }
          else{
            print("YOU ARE NOT OWNER FOR THIS PRODUCT!!");
            showToast(text: 'NOT ALLOWED!!', state: ToastStates.ERROR);
          }
    })
        .catchError((error){
          emit(ShopErrorDeleteProductState());
          print(error.toString());
    });
  }



  MyPostsModel myPostsModel;
  void getMyPostsData(int userId) {
    emit(ShopLoadingMyPostsState());
    DioHelper.getData(
      url: 'product/user/$userId',
      token: token,
    ).then((value) {
      myPostsModel = MyPostsModel.fromJson(value.data);
      print("success My Posts : ${myPostsModel.success}");
      emit(ShopSuccessMyPostsState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorMyPostsState());
    });
  }






}

// ============================================
