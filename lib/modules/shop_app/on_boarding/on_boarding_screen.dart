import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pl/modules/shop_app/login/shop_login_screen.dart';
import 'package:pl/shared/components/components.dart';
import 'package:pl/shared/network/local/cache_helper.dart';
import 'package:pl/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body
  });
}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/3.jpg',
      title: 'شكراً لانضمامكم لأسرتنا',
      body: 'تمتع بأفضل رحلة عروض عبر تطبيق يجمع كل ما تحتاجه في سلة واحدة❤️',
    ),
    BoardingModel(
      image: 'assets/images/4.jpg',
      title: 'On - Boarding -2 Title  ',
      body: 'On - Boarding -2 Body',
    ),
    BoardingModel(
      image: 'assets/images/6.jpg',
      title: 'On - Boarding -3 Title  ',
      body: 'On - Boarding -3 Body',
    ),
    BoardingModel(
      image: 'assets/images/2.png',
      title: 'On - Boarding -3 Title  ',
      body: 'On - Boarding -3 Body',
    ),
    BoardingModel(
      image: 'assets/images/5.png',
      title: 'On - Boarding -3 Title  ',
      body: 'On - Boarding -3 Body',
    ),
  ];

  bool isLast = false;

  var boardController = PageController();


  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        navigateAndFinish(
            context,
            ShopLoginScreen()
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submit,
            text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index){
                  if(index == boarding.length-1){
                    setState(() {
                      isLast = true;
                    });
                    print("Last");
                  }else{
                    print("Not Last");
                    isLast = false;
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      spacing: 5,
                      expansionFactor: 4
                    ),
                    count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }
                    else{
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:AssetImage('${model.image}'),
        ),
      ),
      SizedBox(height: 30.0,),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 15.0,),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 15.0,),
    ],
  );
}
