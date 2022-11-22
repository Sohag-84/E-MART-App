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
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;

  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.data['name']);
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
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
                5.heightBox,
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
                customTextField(
                  title: name,
                  hintText: nameHint,
                  controller: _nameController,
                ),
                5.heightBox,
                customTextField(
                  title: oldPassword,
                  hintText: passwordHint,
                  controller: _oldPasswordController,
                ),
                5.heightBox,
                customTextField(
                  title: newPassword,
                  hintText: passwordHint,
                  controller: _newPasswordController,
                ),
                10.heightBox,
                Obx(() {
                  return SizedBox(
                    width: context.screenWidth - 80,
                    child: customButton(
                      isLoading: profileController.isLoading.value,
                      onPressed: () async {
                        profileController.isLoading(true);

                        //if image is not selected
                        if (profileController
                            .profileImagePath.value.isNotEmpty) {
                          await profileController.uploadProfileImage();
                        } else {
                          profileController.profileImageLink =
                              widget.data['imgUrl'];
                        }

                        //if old password matches database
                        if (widget.data['password'] ==
                            _oldPasswordController.text) {
                          await profileController.changeAuthPassword(
                            email: widget.data['email'],
                            password: _oldPasswordController.text,
                            newPassword: _newPasswordController.text,
                          );

                          await profileController.updatedProfile(
                            name: _nameController.text,
                            password: _newPasswordController.text,
                            imageUrl: profileController.profileImageLink,
                          );
                          Fluttertoast.showToast(msg: "Updated");
                        } else {
                          Fluttertoast.showToast(msg: "Wrong old password");
                          profileController.isLoading(false);
                        }
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
