// ignore_for_file: prefer_const_constructors

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/consts/list.dart';
import 'package:e_mart_app/widgets/home_button.dart';

import 'components/featured_button.dart';

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
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
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
                    10.heightBox,
                    //second slider
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      height: 135,
                      enlargeCenterPage: true,
                      //autoPlayAnimationDuration: Duration(seconds: 1),
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(EdgeInsets.only(right: 10))
                            .make();
                      },
                    ),
                    10.heightBox,
                    //home button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButton(
                          onPressed: () {},
                          width: context.screenWidth / 3.3,
                          height: context.screenHeight * 0.15,
                          title: index == 0
                              ? topCategories
                              : index == 1
                                  ? brand
                                  : topSeller,
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                        ),
                      ),
                    ),
                    //for Featured categories
                    15.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .size(18)
                            .make(),
                      ),
                    ),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Column(
                            children: [
                              featuredButton(
                                img: featuredImageList1[index],
                                title: featuredTitleList1[index],
                              ),
                              10.heightBox,
                              featuredButton(
                                img: featuredImageList2[index],
                                title: featuredTitleList2[index],
                              ),
                            ],
                          ),
                        ).toList(),
                      ),
                    ),
                    //for featured product
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        color: redColor,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text.white.fontFamily(bold).make(),
                            10.heightBox,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  6,
                                  (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      "Laptop 4/64"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      "\$500"
                                          .text
                                          .fontFamily(bold)
                                          .size(16)
                                          .color(redColor)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .white
                                      .rounded
                                      .margin(
                                          EdgeInsets.symmetric(horizontal: 8))
                                      .padding(EdgeInsets.all(8))
                                      .make(),
                                ),
                              ),
                            ),
                            10.heightBox,
                          ],
                        ),
                      ),
                    ),
                    10.heightBox,
                    //third slider
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      height: 135,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(
                              EdgeInsets.only(right: 10),
                            )
                            .make();
                      },
                    ),
                    20.heightBox,
                    //all product section
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Column(
                        children: [
                          10.heightBox,
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 250,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imgPi5,
                                    width: 180,
                                    height: 180,
                                    fit: BoxFit.fill,
                                  ),
                                  10.heightBox,
                                  "iPhone 12 Pro Max"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  "\$580"
                                      .text
                                      .fontFamily(bold)
                                      .size(16)
                                      .color(redColor)
                                      .make(),
                                ],
                              )
                                  .box
                                  .white
                                  .roundedSM
                               .padding(EdgeInsets.symmetric(horizontal: 8))
                                  .make();
                            },
                          ),
                        ],
                      ),
                    ),
                    10.heightBox,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
