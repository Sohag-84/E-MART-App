// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
//import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart' as intl;

Widget senderBubble({required DocumentSnapshot data}) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();

  var time = intl.DateFormat("h:mma").format(t);
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(29),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(15),
      ),
    ),
    child: Column(
      crossAxisAlignment: data['uid'] == currentUser!.uid
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        "${data['msg']}".text.size(16).color(whiteColor).make(),
        10.heightBox,
        time.text.color(whiteColor.withOpacity(.70)).make()
      ],
    ),
  );
}
