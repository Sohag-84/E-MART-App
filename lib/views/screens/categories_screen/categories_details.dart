// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/product_controller.dart';
import 'package:e_mart_app/services/firesoter_services.dart';
import 'package:e_mart_app/views/screens/categories_screen/item_details.dart';
import 'package:e_mart_app/widgets/loading_indicator.dart';

class CategoriesDetails extends StatelessWidget {
  final String title;
  CategoriesDetails({
    Key? key,
    required this.title,
  }) : super(key: key);

  var controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title.text.white.fontFamily(bold).make(),
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getProducts(category: title),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var data = snapshot.data!.docs;
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "No products found!"
                      .text
                      .color(fontGrey)
                      .fontFamily(bold)
                      .make(),
                );
              } else {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(
                            controller.subcat.length,
                            (index) => controller.subcat[index]
                                .toString()
                                .text
                                .size(12)
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .makeCentered()
                                .box
                                .size(120, 50)
                                .white
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .rounded
                                .make(),
                          ),
                        ),
                      ),
                      20.heightBox,
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 250,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_images'][1].toString(),
                                  width: 150,
                                  height: 180,
                                  fit: BoxFit.fill,
                                ),
                                5.heightBox,
                                data[index]['p_name']
                                    .toString()
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                "${data[index]['p_price']}"
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
                                .padding(EdgeInsets.all(12))
                                .outerShadow
                                .roundedSM
                                .make()
                                .onTap(
                              () {
                                controller.checkIfFav(data: data[index]);
                                Get.to(
                                  () => ItemDetails(
                                    title: "${data[index]['p_name']}",
                                    data: data[index],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
