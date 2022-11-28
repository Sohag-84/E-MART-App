// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/product_controller.dart';
import 'package:e_mart_app/services/firesoter_services.dart';
import 'package:e_mart_app/views/screens/categories_screen/item_details.dart';
import 'package:e_mart_app/widgets/loading_indicator.dart';

class CategoriesDetails extends StatefulWidget {
  final String title;
  const CategoriesDetails({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  var controller = Get.find<ProductController>();

  dynamic productMethod;

  switchCategory({required title}) {
    if (controller.subcat.contains(title)) {
      productMethod =
          FirestoreServices.getSubcategoryProducts(subcategory: title);
    } else {
      productMethod = FirestoreServices.getProducts(category: title);
    }
  }

  @override
  void initState() {
    super.initState();
    switchCategory(title: widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: widget.title.text.white.fontFamily(bold).make(),
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      .margin(const EdgeInsets.symmetric(horizontal: 4))
                      .rounded
                      .make()
                      .onTap(() {
                    switchCategory(title: controller.subcat[index]);
                    setState(() {
                      
                    });
                  }),
                ),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(child: loadingIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  return Expanded(
                    child: Center(
                      child:
                          "No products found!".text.color(darkFontGrey).fontFamily(bold).make(),
                    ),
                  );
                } else {
                  return Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        mainAxisExtent: 250,
                      ),
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              data['p_images'][0].toString(),
                              width: 150,
                              height: 180,
                              fit: BoxFit.fill,
                            ),
                            5.heightBox,
                            data['p_name']
                                .toString()
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
                            .padding(EdgeInsets.all(12))
                            .outerShadow
                            .roundedSM
                            .make()
                            .onTap(
                          () {
                            controller.checkIfFav(data: data);
                            Get.to(
                              () => ItemDetails(
                                title: "${data['p_name']}",
                                data: snapshot.data!.docs[index],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
