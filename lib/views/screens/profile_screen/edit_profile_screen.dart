// ignore_for_file: prefer_const_constructors, unused_field, must_be_immutable

import 'dart:io';

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/profile_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfileScreen extends StatefulWidget {
  final data;
  EditProfileScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;

  late TextEditingController _emailController;

  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.data['name']);
    _emailController = TextEditingController(text: widget.data['email']);
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.data['imgUrl'] == '' &&
                        profileController.profileImagePath.isEmpty
                    ? Image.asset(
                        imgProfile2,
                        width: 250,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : widget.data['imgUrl'] != '' &&
                            profileController.profileImagePath.isEmpty
                        ? Image.network(
                            widget.data['imgUrl'].toString(),
                            width: 250,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(profileController.profileImagePath.value),
                            width: 250,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                customButton(
                  isLoading: false,
                  onPressed: () {
                    profileController.changeImage();
                  },
                  bgColor: redColor,
                  textColor: whiteColor,
                  title: "Change",
                ),
                const Divider(),
                20.heightBox,
                customTextField(
                  title: name,
                  hintText: nameHint,
                  controller: _nameController,
                ),
                10.heightBox,
                customTextField(
                  title: email,
                  hintText: emailHint,
                  controller: _emailController,
                ),
                20.heightBox,
                Obx(() {
                  return SizedBox(
                    width: context.screenWidth - 80,
                    child: customButton(
                      isLoading: profileController.isLoading.value,
                      onPressed: () async {
                        profileController.isLoading(true);
                        await profileController.uploadProfileImage();
                        await profileController.updatedProfile(
                          name: _nameController.text,
                          email: _emailController.text,
                          imageUrl: profileController.profileImageLink,
                        );
                        profileController.isLoading(false);
                        Fluttertoast.showToast(msg: "Updated");
                      },
                      bgColor: redColor.withOpacity(.80),
                      textColor: whiteColor,
                      title: "Save",
                    ),
                  );
                })
              ],
            )
                .box
                .white
                .rounded
                .shadowSm
                .p16
                .margin(EdgeInsets.only(top: 50, left: 15, right: 15))
                .make(),
          );
        }),
      ),
    );
  }
}
