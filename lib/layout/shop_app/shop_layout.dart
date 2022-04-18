import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl/layout/shop_app/cubit/cubit.dart';
import 'package:pl/layout/shop_app/cubit/states.dart';
import 'package:pl/modules/shop_app/login/shop_login_screen.dart';
import 'package:pl/modules/shop_app/search/search_screen.dart';
import 'package:pl/shared/components/components.dart';
import 'package:pl/shared/cubit/cubit.dart';
import 'package:pl/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'BIG OFFER',
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search,),
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  }
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottom(index);
            },
            items: [
              BottomNavigationBarItem (
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem (
                  icon: Icon(Icons.playlist_add),
                  label: 'NewProduct'
              ),
              BottomNavigationBarItem (
                  icon: Icon(Icons.person),
                  label: 'MyPosts'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
