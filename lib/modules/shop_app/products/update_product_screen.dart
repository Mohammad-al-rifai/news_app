import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:pl/layout/shop_app/cubit/cubit.dart';
import 'package:pl/layout/shop_app/cubit/states.dart';
import 'package:pl/shared/components/components.dart';

// ignore: must_be_immutable
class UpdateProductScreen extends StatelessWidget {

   int indexProduct;

  UpdateProductScreen(this.indexProduct);



  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var categoryController = TextEditingController();
  var quantityController = TextEditingController();
  var priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EDIT YOUR PRODUCT DATA',style: TextStyle(fontSize: 16.0),),
      ),
      body: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).updateProModel;

          print(model.data.proName);

          // nameController.text = model.data.proName;
          // phoneController.text = model.data.proPhone;
          // categoryController.text = model.data.proCategory;
          // quantityController.text = model.data.proQuantity;
          // priceController.text = model.data.price;

          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EDIT PRODUCT',
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
                    height: 30.0,
                  ),
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) => state is! ShopLoadingUpdateProductState,
                    widgetBuilder: (context) => defaultButton(
                      function: (){
                        if(formKey.currentState.validate()){
                          ShopCubit.get(context).updateProductData(
                              productID: model.data.id,
                              name: nameController.text,
                              category: categoryController.text,
                              phone: phoneController.text,
                              quantity: quantityController.text,
                              price: priceController.text
                          );
                          showToast(text: 'Product Editing Successfully ', state: ToastStates.SUCCESS);
                        }
                      },
                      text: 'save',
                      isUpperCase: true,
                    ),
                    fallbackBuilder: (context) =>Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
