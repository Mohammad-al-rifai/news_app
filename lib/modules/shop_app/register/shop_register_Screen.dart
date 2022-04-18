import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:pl/layout/shop_app/shop_layout.dart';
import 'package:pl/modules/shop_app/register/cubit/cubit.dart';
import 'package:pl/modules/shop_app/register/cubit/states.dart';
import 'package:pl/shared/components/components.dart';
import 'package:pl/shared/components/constants.dart';
import 'package:pl/shared/network/local/cache_helper.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState){
            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data.token
              ).then((value){
                //Important Note! => here The Token Will be saved Every Login Process
                //because after logout the old token is stall saved
                //but we need The new token after logout so we saved it again✔️
                token = state.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());
              });
            }else{
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }

            CacheHelper.saveData(
                key: 'userId',
                value: state.loginModel.data.userId
            ).then((value){
              //Important Note! => here The Token Will be saved Every Login Process
              //because after logout the old token is stall saved
              //but we need The new token after logout so we saved it again✔️
              userId = state.loginModel.data.userId;
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 15.0,),
                        Text(
                          'Register now to Browse our hot offers ',
                          style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.text,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Your Name';
                              }
                            },
                            label: 'Name',
                            prefix: Icons.person
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Your Email Address';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Password Is Too Short!!';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            isPassword: ShopRegisterCubit.get(context).isPassWord,
                            suffixAction: (){
                              ShopRegisterCubit.get(context).changeVisibility();
                            },
                            onSubmit: (value){
                            }
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Password Is Too Short!!';
                              }
                            },
                            label: 'Confirm-Password',
                            prefix: Icons.lock_outline,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            isPassword: ShopRegisterCubit.get(context).isPassWord,
                            suffixAction: (){
                              ShopRegisterCubit.get(context).changeVisibility();
                            },
                            onSubmit: (value){
                            }
                        ),
                        SizedBox(height: 15.0,),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Your Phone';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone
                        ),
                        SizedBox(height: 30.0,),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) => state is! ShopRegisterLoadingState,
                          widgetBuilder: (context) => defaultButton(
                            function: (){
                              if(formKey.currentState.validate()){
                                ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                );
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
