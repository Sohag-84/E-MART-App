// ignore_for_file: prefer_const_constructors, unused_field

import 'dart:io';

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  final profileController = Get.put(ProfileController());

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
           () {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                profileController.profileImagePath.isEmpty
                    ? Image.asset(
                        imgProfile2,
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
                customTextField(
                  title: password,
                  hintText: passwordHint,
                  controller: _passwordController,
                ),
                20.heightBox,
                SizedBox(
                  width: context.screenWidth - 80,
                  child: customButton(
                    isLoading: false,
                    onPressed: () {},
                    bgColor: redColor.withOpacity(.80),
                    textColor: whiteColor,
                    title: "Save",
                  ),
                )
              ],
            )
                .box
                .white
                .rounded
                .shadowSm
                .p16
                .margin(EdgeInsets.only(top: 50, left: 15, right: 15))
                .make();
          }
        ),
      ),
    );
  }
}
