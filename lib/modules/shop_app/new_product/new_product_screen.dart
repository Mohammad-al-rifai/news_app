import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pl/layout/shop_app/cubit/cubit.dart';
import 'package:pl/layout/shop_app/cubit/states.dart';
import 'package:pl/modules/shop_app/new_product/ImagePickerScreen.dart';
import 'package:pl/modules/shop_app/new_product/discount_screen.dart';
import 'package:pl/modules/shop_app/products/products_screen.dart';
import 'package:pl/shared/components/components.dart';
import 'package:pl/shared/components/constants.dart';
import 'package:pl/shared/styles/colors.dart';

// ignore: must_be_immutable
class NewProductScreen extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var imageController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var categoryController = TextEditingController();
  var expDateController = TextEditingController();
  var quantityController = TextEditingController();
  var priceController = TextEditingController();


  File image;
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){
        if(state is ShopSuccessCreateProductState){
          // navigateTo(context, ProductsScreen());
        }
      },
      builder: (context, state){
        return Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NEW PRODUCT',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.image_outlined,
                                      color: defaultColor,
                                      semanticLabel: 'Gallery',
                                    ),
                                    onPressed: () async{
                                      final myFile = await ImagePicker().getImage(source: ImageSource.gallery, /*imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0*/);
                                      image = File(myFile.path);
                                      print("Image Is: ");
                                      print(image);
                                    },
                                    iconSize: 50.0,
                                  ),
                                  Text('Gallery'),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      color: defaultColor,
                                    ),
                                    onPressed: () async{
                                      final myFile = await ImagePicker().getImage(source: ImageSource.camera, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
                                      image = File(myFile.path);
                                      print("Image From Camera Is: ");
                                      print(image);
                                    },
                                    iconSize: 50.0,
                                  ),
                                  Text(
                                    'Camera',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.text,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                            },
                            label: 'Product\'s Name',
                            prefix: Icons.drive_file_rename_outline),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: categoryController,
                            type: TextInputType.text,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Category!!';
                              }
                            },
                            label: 'Category',
                            prefix: Icons.category_outlined),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: expDateController,
                            type: TextInputType.text,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.parse('2020-12-30'),
                                lastDate: DateTime.parse('2022-12-30'),
                              ).then((value) {
                                expDateController.text =
                                    DateFormat.yMMMd().format(value);
                              });
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Date Must Not Be Empty!';
                              }
                              return null;
                            },
                            label: 'Expired-Date',
                            prefix: Icons.calendar_today_outlined,
                            suffix: Icons.update_outlined),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Phone';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: quantityController,
                            type: TextInputType.number,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Quantity Of Your Product';
                              }
                            },
                            label: 'Quantity',
                            prefix: Icons.add),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: priceController,
                            type: TextInputType.number,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Price again';
                              }
                            },
                            label: 'Price',
                            prefix: Icons.monetization_on_outlined),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultButton(
                          function: () {
                            navigateTo(context, DiscountScreen());
                          },
                          text: 'DISCOUNTS PAGE',
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) => state is! ShopLoadingCreateProductState,
                          widgetBuilder: (context) => defaultButton(
                            function: (){
                              if(image == null) showToast(text: 'Image Must Not Be Empty!', state: ToastStates.ERROR);
                              if(ShopCubit.get(context).discounts.isEmpty == true) showToast(text: 'Discount List Must Not Be Empty!', state: ToastStates.ERROR);
                              if(formKey.currentState.validate() && image != null && ShopCubit.get(context).discounts.isEmpty == false){
                                ShopCubit.get(context).createNewProduct(
                                    name: nameController.text,
                                    category: categoryController.text,
                                    expiredDate: expDateController.text,
                                    phone: phoneController.text,
                                    quantity: quantityController.text,
                                    price: priceController.text,
                                    url: image,
                                    title: image.path.split('/').last,
                                    discountList: ShopCubit.get(context).discounts
                                );
                                showToast(text: 'Product Successfully Added', state: ToastStates.SUCCESS);
                                print("Discount List Is: ");
                                print(ShopCubit.get(context).discounts);
                              }
                            },
                            text: 'send',
                            isUpperCase: true,
                          ),
                          fallbackBuilder: (context) =>Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
