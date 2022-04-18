import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pl/layout/shop_app/cubit/cubit.dart';
import 'package:pl/layout/shop_app/cubit/states.dart';
import 'package:pl/shared/components/components.dart';

class DiscountScreen extends StatefulWidget {

  @override
  _DiscountScreenState createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var percentageController = TextEditingController();
  var discountController = TextEditingController();

  
  
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(title: Text('ADD Your Discounts Here!'),),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    defaultFormField(
                        controller: percentageController,
                        type: TextInputType.number,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Discount-Percentage Must Not Be Empty!';
                          }
                          return null;
                        },
                        label: 'Discount-Percentage',
                        prefix: Icons.title),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultFormField(
                        controller: discountController,
                        type: TextInputType.text,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2022-12-30'),
                          ).then((value) {
                            discountController.text =
                                DateFormat.yMMMd().format(value);
                          });
                        },
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Date Must Not Be Empty!';
                          }
                          return null;
                        },
                        label: 'After Date',
                        prefix: Icons.calendar_today_outlined),
                    SizedBox(
                      height: 15.0,
                    ),
                    defaultButton(
                      function: (){
                        if(formKey.currentState.validate()){
                          setState(() {
                            ShopCubit.get(context).discounts.add({
                              'discount_percentage':percentageController.text,
                              'date':discountController.text
                            });
                            print("Add SUCCESS");
                            print(ShopCubit.get(context).discounts);
                          });
                        }
                      },
                      text:'send',
                      isUpperCase: true,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder:(context,index)=> discountItem(ShopCubit.get(context).discounts[index]),
                        separatorBuilder: (context,index)=>Padding(
                          padding: const EdgeInsetsDirectional.only(start: 40.0),
                          child: Container(height: 1.0,width: 1.0,color: Colors.black,),
                        ),
                        itemCount: ShopCubit.get(context).discounts.length
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
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          child: Text(
            '${map['discount_percentage']}%',
            style: TextStyle(fontSize: 30.0),
          ),
          radius: 40.0,
        ),
        SizedBox(width: 10.0,),
        Expanded(
            child: Text('Offer Available At: ${map['date']} ')
        ),
      ],
    ),
  );


}
