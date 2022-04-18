import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:pl/layout/shop_app/cubit/cubit.dart';
import 'package:pl/layout/shop_app/cubit/states.dart';
import 'package:pl/shared/components/components.dart';
import 'package:pl/shared/components/constants.dart';
import 'package:pl/shared/cubit/cubit.dart';
import 'package:pl/shared/cubit/states.dart';

// ignore: must_be_immutable
class SettingScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Conditional.single(
            context: context,
            conditionBuilder: (context) => true,
            widgetBuilder: (context) => Padding(
              padding:const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          child: Icon(Icons.person,size: 40.0,),
                        ),
                        SizedBox(width: 10.0,),
                        Expanded(
                          child: defaultButton(
                              function: (){
                                signOut(context);
                              },
                              text:'LOGOUT',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.0,),
                    BlocConsumer<AppCubit,AppStates>(
                      listener: (context,state) {},
                      builder: (context,state) {
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              child: Icon(Icons.brightness_4_outlined,size: 40.0,),
                            ),
                            SizedBox(width: 10.0,),
                            Expanded(
                              child: defaultButton(
                                function: (){
                                  AppCubit.get(context).changeAppMode();
                                },
                                text:'AppMode',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            fallbackBuilder: (context) => Center(child: CircularProgressIndicator())
          ),
        );
      },
    );
  }
}
