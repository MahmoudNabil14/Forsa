
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/modules/login_screen/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onBoardingModel{
  final String title;
  final String image;
  final String body;

  onBoardingModel(
      this.title,
      this.image,
      this.body
      );
}

class OnBoardingScreen extends StatelessWidget {

  bool isLast = false;

  var boardingController = PageController();
  List<onBoardingModel> boarding = [
    onBoardingModel('onBoarding 1', 'assets/images/on_boarding.png', 'boooooooooooody 1'),
    onBoardingModel('onBoarding 2', 'assets/images/on_boarding.png', 'boooooooooooody 2'),
    onBoardingModel('onBoarding 3', 'assets/images/on_boarding.png', 'boooooooooooody 3'),
  ];

   void submit(context){
     CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
     {
       if(value)
       {
         navigateAndEnd(context, ShopLoginScreen());
       }
     });
   }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit(context);
              },
              child: Text('SKIP'))
        ],
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index == boarding.length - 1){
                    isLast = true ;
                  }else{
                    isLast = false;
                  }
                },
                controller: boardingController,
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=> BoardingItem(boarding[index]),
              ),
            ),
            SizedBox(height: 30.0,),
            Row(
              children: [
                SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      expansionFactor: 3.5,
                      spacing: 5.0
                    ),
                    controller: boardingController,
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast == true){
                      submit(context);
                    }else{
                      boardingController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BoardingItem(onBoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child:
        Image(
            image: AssetImage('${model.image}')
        ),
      ),
      Text('${model.title}',
        style: TextStyle(
          fontSize: 24.0,
        ),),
      SizedBox(height: 15.0,),
      Text('${model.body}',
        style: TextStyle(
          fontSize: 14.0,
        ),),
      SizedBox(height: 30.0,),
    ],
  );
}



