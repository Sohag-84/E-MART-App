// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/services/firesoter_services.dart';
import 'package:e_mart_app/views/screens/categories_screen/item_details.dart';
import 'package:e_mart_app/widgets/loading_indicator.dart';

class SearchScreen extends StatelessWidget {
  final String title;
  const SearchScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: darkFontGrey),
        title: title.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title: title),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return "No product found!!"
                .text
                .color(darkFontGrey)
                .fontFamily(bold)
                .size(16)
                .letterSpacing(1)
                .makeCentered();
          } else {
            var filtered = snapshot.data!.docs
                .where(
                  (element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title.toLowerCase()),
                )
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      Image.network(
                        "${filtered[index]['p_images'][0]}",
                        width: 180,
                        height: 180,
                        fit: BoxFit.fill,
                      ),
                      10.heightBox,
                      "${filtered[index]['p_name']}"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      "${filtered[index]['p_price']}"
                          .text
                          .fontFamily(bold)
                          .size(16)
                          .color(redColor)
                          .make(),
                    ],
                  )
                      .box
                      .red100
                      .roundedSM
                      .outerShadowMd
                      .padding(EdgeInsets.symmetric(horizontal: 8))
                      .make()
                      .onTap(() {
                    Get.to(
                      () => ItemDetails(
                        title: filtered[index]['p_name'],
                        data: filtered[index],
                      ),
                    );
                  });
                },
              ),
            );
          }
        },
      ),
    );
  }
}
