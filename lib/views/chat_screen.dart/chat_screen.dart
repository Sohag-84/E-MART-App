// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/chat_controller.dart';
import 'package:e_mart_app/services/firesoter_services.dart';
import 'package:e_mart_app/views/chat_screen.dart/components/sender_bubble.dart';
import 'package:e_mart_app/widgets/loading_indicator.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ChatController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: darkFontGrey),
        title: "${chatController.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() {
              return chatController.isLoading.value
                  ? loadingIndicator()
                  : Expanded(
                      child: StreamBuilder(
                        stream: FirestoreServices.getChatMessages(
                            docId: chatController.chatDocId.toString()),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return loadingIndicator();
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: "Send a message.."
                                  .text
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: senderBubble(data: data));
                              }).toList(),
                            );
                          }
                        },
                      ),
                    );
            }),
            10.heightBox,
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: chatController.messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textFieldGrey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textFieldGrey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textFieldGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    chatController.sendMsg(
                      msg: chatController.messageController.text,
                    );
                    chatController.messageController.clear();
                  },
                  icon: Icon(
                    Icons.send,
                    color: redColor,
                    size: 35,
                  ),
                ),
              ],
            )
                .box
                .height(60)
                .height(80)
                .p12
                .margin(EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }
}
