// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/product_controller.dart';
import 'package:e_mart_app/views/screens/categories_screen/item_details.dart';

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
        body: Container(
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
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
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
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 250,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          imgPi4,
                          width: 150,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
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
                        .padding(EdgeInsets.all(12))
                        .outerShadow
                        .roundedSM
                        .make()
                        .onTap(
                          () => Get.to(
                            () => ItemDetails(title: "item details"),
                          ),
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
