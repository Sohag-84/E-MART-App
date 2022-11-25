// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/consts/list.dart';
import 'package:e_mart_app/controller/product_controller.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: darkFontGrey),
        title: title.text.fontFamily(bold).color(darkFontGrey).make(),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //show slider
                    VxSwiper.builder(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      itemCount: data["p_images"].length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          "${data['p_images'][index]}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),

                    //title and details section
                    10.heightBox,
                    title.text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .size(16)
                        .make(),
                    10.heightBox,

                    //rating
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data["p_rating"]),
                      onRatingUpdate: (value) {},
                      normalColor: textFieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                    ),
                    10.heightBox,
                    "${data['p_price']}"
                        .numCurrency
                        .text
                        .fontFamily(bold)
                        .color(redColor)
                        .size(18)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Seller".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data['p_seller']}"
                                  .text
                                  .color(darkFontGrey)
                                  .size(16)
                                  .fontFamily(semibold)
                                  .make(),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: whiteColor,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        ),
                      ],
                    )
                        .box
                        .height(60)
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .color(textFieldGrey)
                        .make(),

                    //color selection
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Color: ".text.color(darkFontGrey).make(),
                            ),
                            Obx(
                              () {
                                return Row(
                                  children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .size(40, 40)
                                            .roundedFull
                                            .color(Color(int.parse(
                                                    data['p_colors'][index]))
                                                .withOpacity(1.0))
                                            .margin(
                                              EdgeInsets.symmetric(horizontal: 4),
                                            )
                                            .make()
                                            .onTap(() {
                                          controller.changeColorIndex(index: index);
                                        }),
                                        Visibility(
                                          visible:
                                              index == controller.colorIndex.value,
                                          child: Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            ),
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),

                        //quantity row
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  "Quantity: ".text.color(darkFontGrey).make(),
                            ),
                            Obx(() {
                              return Row(
                                children: [
                                  IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.remove),
                                  ),
                                  controller.quantity.value.text
                                      .fontFamily(bold)
                                      .color(darkFontGrey)
                                      .make(),
                                  IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.add),
                                  ),
                                  10.widthBox,
                                  "(${data['p_quantity']} available)"
                                      .text
                                      .color(textFieldGrey)
                                      .make()
                                ],
                              );
                            }),
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),

                        //total amount
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Total: ".text.color(darkFontGrey).make(),
                            ),
                            "\$0.0"
                                .text
                                .fontFamily(bold)
                                .color(redColor)
                                .size(16)
                                .make(),
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),
                      ],
                    ).box.white.shadow.make(),
                    10.heightBox,

                    //description section
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    "${data['p_desc']}".text.color(darkFontGrey).make(),

                    //bottom section
                    10.heightBox,
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                        itemDetailsButtonList.length,
                        (index) => ListTile(
                          title: itemDetailsButtonList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                    15.heightBox,
                    productsYouMayLike.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              .margin(EdgeInsets.symmetric(horizontal: 8))
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
          ),
          15.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: customButton(
                    isLoading: false,
                    onPressed: () {},
                    bgColor: redColor,
                    textColor: whiteColor,
                    title: "Add to Cart",
                  ),
                ),
                15.widthBox,
                Expanded(
                  child: customButton(
                    isLoading: false,
                    onPressed: () {},
                    bgColor: Colors.orangeAccent,
                    textColor: whiteColor,
                    title: "Buy Now",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
