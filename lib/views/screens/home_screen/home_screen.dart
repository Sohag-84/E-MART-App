// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/consts/list.dart';
import 'package:e_mart_app/controller/home_controller.dart';
import 'package:e_mart_app/services/firesoter_services.dart';
import 'package:e_mart_app/views/screens/categories_screen/item_details.dart';
import 'package:e_mart_app/views/screens/home_screen/search_screen.dart';
import 'package:e_mart_app/widgets/home_button.dart';
import 'package:e_mart_app/widgets/loading_indicator.dart';

import 'components/featured_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();

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
                controller: controller.searchController,
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
                  ).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: controller.searchController.text,
                          ));
                    }
                  }),
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
                              child: FutureBuilder(
                                  future:
                                      FirestoreServices.getFeaturedProduct(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return loadingIndicator();
                                    } else if (snapshot.data!.docs.isEmpty) {
                                      return "No featured products"
                                          .text
                                          .white
                                          .makeCentered();
                                    } else {
                                      return Row(
                                        children: List.generate(
                                          snapshot.data!.docs.length,
                                          (index) {
                                            var data =
                                                snapshot.data!.docs[index];

                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  "${data['p_images'][0]}",
                                                  width: 150,
                                                  height: 160,
                                                  fit: BoxFit.fill,
                                                ),
                                                "${data['p_name']}"
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                "${data['p_price']}"
                                                    .numCurrency
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
                                                .margin(EdgeInsets.symmetric(
                                                    horizontal: 8))
                                                .padding(EdgeInsets.all(8))
                                                .make()
                                                .onTap(() {
                                              Get.to(
                                                () => ItemDetails(
                                                  title: snapshot.data!
                                                      .docs[index]['p_name'],
                                                  data: snapshot
                                                      .data!.docs[index],
                                                ),
                                              );
                                            });
                                          },
                                        ),
                                      );
                                    }
                                  }),
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
                      itemCount: thirdSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          thirdSliderList[index],
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: "All products"
                                .text
                                .color(darkFontGrey)
                                .size(18)
                                .fontFamily(bold)
                                .make(),
                          ),
                          10.heightBox,
                          StreamBuilder(
                            stream: FirestoreServices.getAllProducts(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return loadingIndicator();
                              } else {
                                var productData = snapshot.data!.docs;
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: productData.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 250,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          "${productData[index]['p_images'][0]}",
                                          width: 180,
                                          height: 180,
                                          fit: BoxFit.fill,
                                        ),
                                        10.heightBox,
                                        "${productData[index]['p_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .color(darkFontGrey)
                                            .make(),
                                        "${productData[index]['p_price']}"
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
                                        .padding(
                                            EdgeInsets.symmetric(horizontal: 8))
                                        .make()
                                        .onTap(() {
                                      Get.to(
                                        () => ItemDetails(
                                          title: snapshot.data!.docs[index]
                                              ['p_name'],
                                          data: snapshot.data!.docs[index],
                                        ),
                                      );
                                    });
                                  },
                                );
                              }
                            },
                          )
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
