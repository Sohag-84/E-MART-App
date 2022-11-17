// ignore_for_file: prefer_const_constructors

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/consts/list.dart';
import 'package:e_mart_app/views/auth_screen/signup_screen.dart';
import 'package:e_mart_app/views/screens/home.dart';
import 'package:e_mart_app/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Login in to ${appname}"
                  .text
                  .size(18)
                  .fontFamily(bold)
                  .white
                  .make(),
              30.heightBox,
              Column(
                children: [
                  customTextField(
                    title: email,
                    hintText: emailHint,
                    controller: _emailController,
                  ),
                  10.heightBox,
                  customTextField(
                    title: password,
                    hintText: passwordHint,
                    controller: _passwordController,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: null,
                      child: forgetPassword.text.make(),
                    ),
                  ),
                  5.heightBox,
                  customButton(
                    onPressed: () => Get.to(()=> Home(),),
                    bgColor: redColor,
                    textColor: whiteColor,
                    title: login,
                  ).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  customButton(
                    onPressed: () {
                      Get.to(()=>SignupScreen());
                    },
                    bgColor: lightGolden,
                    textColor: redColor,
                    title: signup,
                  ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 25,
                          child: Image.asset(
                            socialIconList[index],
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .p16
                  .shadowSm
                  .width(context.screenWidth - 50)
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
