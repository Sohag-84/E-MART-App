// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/consts/list.dart';
import 'package:e_mart_app/controller/auth_controller.dart';
import 'package:e_mart_app/services/firesoter_services.dart';
import 'package:e_mart_app/views/screens/chat_screen.dart/messaging_screen.dart';
import 'package:e_mart_app/views/screens/order_screen/order_screen.dart';
import 'package:e_mart_app/views/screens/profile_screen/components/details_card.dart';
import 'package:e_mart_app/views/screens/profile_screen/edit_profile_screen.dart';
import 'package:e_mart_app/views/screens/wishlist_screen/wishlists_screen.dart';
import 'package:e_mart_app/widgets/loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        body: SafeArea(
          child: StreamBuilder(
            stream: FirestoreServices.getUser(userUid: currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];
                return Column(
                  children: [
                    //edit profile button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        ),
                      ).onTap(() {
                        Get.to(() => EditProfileScreen(
                              data: data,
                            ));
                      }),
                    ),

                    //user details section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['imgUrl'] == ''
                              ? Image.asset(
                                  imgProfile2,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['imgUrl'].toString(),
                                  width: 100,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),
                          7.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                data['name']
                                    .toString()
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                2.heightBox,
                                data['email'].toString().text.white.make(),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: whiteColor),
                            ),
                            onPressed: () async {
                              await Get.put(AuthContorller().signoutMethod());
                            },
                            child:
                                logout.text.white.fontFamily(semibold).make(),
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    FutureBuilder(
                        future: FirestoreServices.getCount(),
                        builder:
                            (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return loadingIndicator();
                          } else {
                            var countData = snapshot.data;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                detailsCard(
                                  count: countData[0].toString(),
                                  title: "in your cart",
                                  width: context.screenWidth / 3.4,
                                ),
                                detailsCard(
                                  count: countData[1].toString(),
                                  title: "in your wishlist",
                                  width: context.screenWidth / 3.4,
                                ),
                                detailsCard(
                                  count: countData[2].toString(),
                                  title: "your orders",
                                  width: context.screenWidth / 3.4,
                                ),
                              ],
                            );
                          }
                        }),
                    //button section
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: profileButtonList.length,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: lightGrey,
                        );
                      },
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => WishlistScreen());
                                break;
                              case 1:
                                Get.to(() => OrderScreen());
                                break;
                              case 2:
                                Get.to(() => MessagesScreen());
                                break;
                              default:
                            }
                          },
                          title: profileButtonList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          leading: Image.asset(
                            profileButtonIconList[index],
                            width: 22,
                          ),
                        );
                      },
                    )
                        .box
                        .rounded
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .margin(EdgeInsets.all(12))
                        .white
                        .shadowSm
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
