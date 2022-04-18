import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl/modules/shop_app/search/cubit/cubit.dart';
import 'package:pl/modules/shop_app/search/cubit/states.dart';
import 'package:pl/shared/components/components.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Please Enter Text To Search it!';
                          }
                          return null;
                        },
                        label: 'search',
                        prefix: Icons.search,
                        onSubmit: (String text){
                          SearchCubit.get(context).search(text);
                        }
                    ),
                    SizedBox(height: 10.0,),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 30.0,),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index) =>buildListProduct(
                                SearchCubit.get(context).model.message[index],
                                context,
                            ),
                            separatorBuilder: (context,index) =>myDivider(),
                            itemCount: SearchCubit.get(context).model.message.length
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
