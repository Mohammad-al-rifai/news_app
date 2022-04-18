import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:pl/layout/shop_app/cubit/cubit.dart';
import 'package:pl/layout/shop_app/cubit/states.dart';
import 'package:pl/models/shop_app/home_model.dart';
import 'package:pl/models/shop_app/product_details_model.dart';
import 'package:pl/modules/shop_app/products/product_details_screen.dart';
import 'package:pl/shared/components/components.dart';
import 'package:pl/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                ShopCubit.get(context).homeModel != null,
            widgetBuilder: (context) => productsBuilder(
                ShopCubit.get(context).homeModel,context
            ),
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsBuilder(HomeModel model, context){

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.6,
              children: List.generate(
                  model.products.length,
                      (index) => InkWell(
                    onTap: ()async{
                      DetailsModel detailsModel =  ShopCubit.get(context).getProDetailsData(model.products[index]['id']);
                      print("HERE YOUR PRO_ID IS: ${model.products[index]['id']}");
                      print("HERE YOUR COMMENT COUNT IS: ${detailsModel.data.commentsCount}");
                      print("HERE YOUR COMMENT LIST IS: ${detailsModel.data.comments}");
                      navigateTo(context, ProductDetailsScreen(index,detailsModel),);
                    },
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            // alignment: AlignmentDirectional.bottomStart,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Image(
                                  image: NetworkImage(
                                    model.products[index]['url'],
                                  ),
                                  width: double.infinity,
                                  height: 200.0,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                    return Text('Your error widget here...');
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    model.products[index]['pro_name'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.0, height: 1.3),
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text('${model.products[index]['views']}'),
                                    SizedBox(width: 5.0,),
                                    Icon(
                                        Icons.remove_red_eye_outlined,
                                      color: defaultColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
