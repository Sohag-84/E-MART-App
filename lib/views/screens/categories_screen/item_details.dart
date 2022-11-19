// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/consts/list.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  const ItemDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      height: 280,
                      aspectRatio: 16 / 9,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          imgFc9,
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
                      onRatingUpdate: (value) {},
                      normalColor: textFieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      stepInt: true,
                    ),
                    10.heightBox,
                    "\$30,000"
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
                              "In House Brands"
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
                            Row(
                              children: List.generate(
                                3,
                                (index) => VxBox()
                                    .size(40, 40)
                                    .roundedFull
                                    .color(Vx.randomPrimaryColor)
                                    .margin(EdgeInsets.symmetric(horizontal: 4))
                                    .make(),
                              ),
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
                            Row(
                              children: [
                                IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.remove),
                                ),
                                "0"
                                    .text
                                    .fontFamily(bold)
                                    .color(darkFontGrey)
                                    .make(),
                                IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.add),
                                ),
                                10.widthBox,
                                "(0 available)".text.color(textFieldGrey).make()
                              ],
                            ),
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
                    "This is a dummy item and dummy description here.."
                        .text
                        .color(darkFontGrey)
                        .make(),

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
                    onPressed: () {},
                    bgColor: redColor,
                    textColor: whiteColor,
                    title: "Add to Cart",
                  ),
                ),
                15.widthBox,
                Expanded(
                  child: customButton(
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
