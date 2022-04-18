import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl/layout/shop_app/cubit/cubit.dart';
import 'package:pl/layout/shop_app/cubit/states.dart';
import 'package:pl/models/shop_app/product_details_model.dart';
import 'package:pl/modules/shop_app/products/update_product_screen.dart';
import 'package:pl/shared/components/components.dart';
import 'package:pl/shared/styles/colors.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {

final int indexProduct;
final DetailsModel detailsModel;

   ProductDetailsScreen(this.indexProduct, this.detailsModel);


var scaffoldKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();

var commentController = TextEditingController();

@override
Widget build(BuildContext context) {
    print('COMMENT_COUNT: ${ShopCubit.get(context).detailsModel.data.commentsCount}');
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder: (context, state){
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.homeModel.products[indexProduct]['pro_name']),
            actions: [
              TextButton(
                onPressed: (){
                  navigateTo(context, UpdateProductScreen(cubit.homeModel.products[indexProduct]['id']));
                },
                child: Row(
                  children: [
                    Icon(Icons.edit,color: Colors.red,),
                  ],
                ),
              ),
              TextButton(
                  onPressed: (){
                      ShopCubit.get(context).deleteProduct(ShopCubit.get(context).detailsModel.data.id,context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.delete_rounded,color: Colors.red,),
                    ],
                  ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            image: NetworkImage(
                                cubit.homeModel.products[indexProduct]['url']),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.homeModel.products[indexProduct]['pro_name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.0, height: 1.3),
                          ),
                          Row(
                            children: [
                              Text(
                                'Old Price: ${cubit.homeModel.products[indexProduct]['price']}',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: defaultColor),
                              ),
                              Spacer(),
                              Text(
                                'Price OFFER:${ShopCubit.get(context).detailsModel.data.thePriceAfterDiscount != null ?ShopCubit.get(context).detailsModel.data.thePriceAfterDiscount : cubit.homeModel.products[indexProduct]['price']}',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                                width: double.infinity,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(start: 20.0,end: 5.0),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            foregroundColor: defaultColor,
                                            radius: 20.0,
                                            child: IconButton(
                                              onPressed: (){
                                                ShopCubit.get(context).like(ShopCubit.get(context).detailsModel.data.id);
                                                ShopCubit.get(context).changeLikeState();
                                              },
                                              icon: Icon(
                                                  ShopCubit.get(context).iconData,
                                                size: 25.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text('${ShopCubit.get(context).detailsModel.data.likesCount != null? ShopCubit.get(context).detailsModel.data.likesCount : 0  } '),
                                      ],
                                    ),
                                    SizedBox(width: 20.0,),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(start: 15.0,end: 5.0),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            foregroundColor: defaultColor,
                                            radius: 20.0,
                                            child: IconButton(
                                              onPressed: ()async{
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) => new AlertDialog(
                                                      title: new Text('YOUR COMMENT'),
                                                      content: defaultFormField(
                                                          controller: commentController,
                                                          type: TextInputType.text,
                                                          validate: (String value){
                                                            return 'Share Your comment!';
                                                          },
                                                          label: 'Add Comment',
                                                          prefix: Icons.mode_comment_rounded,
                                                      ),
                                                      actions: <Widget>[
                                                        new IconButton(
                                                            icon: new Icon(Icons.close),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            }),
                                                        new IconButton(
                                                            icon: new Icon(Icons.send),
                                                            onPressed: (){
                                                              ShopCubit.get(context).comment(
                                                                  productID: ShopCubit.get(context).detailsModel.data.id,
                                                                  comment: commentController.text
                                                              );
                                                              Navigator.pop(context);
                                                        }),
                                                      ],
                                                    ));
                                              },
                                              icon: Icon(
                                                Icons.mode_comment_outlined,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${ShopCubit.get(context).detailsModel.data.commentsCount}',
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 20.0,),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.only(start: 15.0,end: 5.0),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            foregroundColor: defaultColor,
                                            radius: 20.0,
                                            child: Icon(
                                              Icons.remove_red_eye_outlined,
                                            ),
                                          ),
                                        ),
                                        Text('${ShopCubit.get(context).detailsModel.data.views}'),
                                      ],
                                    ),
                                  ],
                                ),
                            ),
                          ),
                          SizedBox(height: 20.0,),
                          Text(
                            'Product\'s Category: ${cubit.homeModel.products[indexProduct]['pro_Category']}'
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                              'Product\'s Owner Phone: ${cubit.homeModel.products[indexProduct]['pro_phone']}'
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                              'Product\'s Quantity: ${cubit.homeModel.products[indexProduct]['pro_quantity']}'
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                              'This Product Will Expired On Date!: : ${cubit.homeModel.products[indexProduct]['pro_expiration_Date']}'
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            'DISCOUNT LIST:',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder:(context,index)=> discountItem(cubit.homeModel.products[indexProduct]['discounts'][index]),
                              separatorBuilder: (context,index)=>Padding(
                                padding: const EdgeInsetsDirectional.only(start: 40.0),
                                child: Container(height: 1.0,width: 1.0,color: Colors.black,),
                              ),
                              itemCount: cubit.homeModel.products[indexProduct]['discounts'].length
                          ),
                          SizedBox(height: 20.0,),
                          Text(
                              'All Comments',
                            style: TextStyle(
                              fontSize: 25.0
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder:(context,index)=> commentItem(ShopCubit.get(context).detailsModel.data.comments[index]),
                              separatorBuilder: (context,index)=>Padding(
                                padding: const EdgeInsetsDirectional.only(start: 40.0),
                                child: Container(height: 1.0,width: 1.0,color: Colors.black,),
                              ),
                              itemCount: ShopCubit.get(context).detailsModel.data.comments.length
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }



Widget discountItem(Map map) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(
    children: [
      CircleAvatar(
        child: Text(
          '${map['discount_percentage']}%',
          style: TextStyle(fontSize: 20.0),
        ),
        radius: 30.0,
        backgroundColor: defaultColor,
        foregroundColor: Colors.white,
      ),
      SizedBox(width: 10.0,),
      Expanded(
          child: Text('Offer Available At: ${map['date']} ')
      ),
    ],
  ),
);


Widget commentItem(Map map) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(
    width: double.infinity,
    child: Column(
      children: [
        Text(
          '${map['user_name']}',
          style: TextStyle(
            fontSize: 20.0,
            color: defaultColor,
            fontStyle: FontStyle.italic,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.0,),
        Text('Comment: ${map['comment']} '),
      ],
    ),
  ),
);
}
