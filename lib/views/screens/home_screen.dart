// ignore_for_file: prefer_const_constructors

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/consts/list.dart';
import 'package:e_mart_app/widgets/home_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight,
      width: context.screenWidth,
      color: lightGrey,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              color: lightGrey,
              child: TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: whiteColor,
                  filled: true,
                  hintText: searchAnything,
                  hintStyle: TextStyle(color: textFieldGrey),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.blueGrey,
                    size: 30,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: lightGrey),
                  ),
                ),
              ),
            ),
            //SizedBox(height: 10),
            //show slider
            VxSwiper.builder(
              aspectRatio: 16 / 9,
              height: 135,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayAnimationDuration: Duration(milliseconds: 600),
              itemCount: sliderList.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  sliderList[index],
                  fit: BoxFit.fill,
                )
                    .box
                    .rounded
                    .clip(Clip.antiAlias)
                    .margin(EdgeInsets.only(right: 10))
                    .make();
              },
            ),
            15.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                2,
                (index) => homeButton(
                  onPressed: () {},
                  width: context.screenWidth / 2.5,
                  height: context.screenHeight * .15,
                  title: index == 0 ? todayDeal : flashSell,
                  icon: index == 0 ? icTodaysDeal : icFlashDeal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
