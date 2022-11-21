// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();

  bool _isChecked = false;

  final authController = Get.put(AuthContorller());

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: bgWidget(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //(context.screenHeight * 0.1).heightBox,
                  appLogoWidget(),
                  10.heightBox,
                  "Join the $appname"
                      .text
                      .size(18)
                      .fontFamily(bold)
                      .white
                      .make(),
                  30.heightBox,
                  Column(
                    children: [
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
                      10.heightBox,
                      customTextField(
                        title: password,
                        hintText: passwordHint,
                        controller: _passwordController,
                      ),
                      10.heightBox,
                      customTextField(
                        title: retypePasswod,
                        hintText: passwordHint,
                        controller: _retypePasswordController,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: null,
                          child: forgetPassword.text.make(),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              activeColor: redColor,
                              checkColor: whiteColor,
                              value: _isChecked,
                              onChanged: (newValue) {
                                setState(() {
                                  _isChecked = newValue!;
                                });
                              }),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: const [
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: termsAndCondition,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Obx(() {
                        return customButton(
                          isLoading: authController.isLoading.value,
                          onPressed: () async {
                            authController.isLoading(true);
                            if (_isChecked != false) {
                              if (_passwordController.text ==
                                  _retypePasswordController.text) {
                                try {
                                  await authController.signupMethod(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                } catch (e) {
                                  await authController.signoutMethod();
                                  VxToast.show(context, msg: e.toString());
                                }
                              } else {
                                VxToast.show(context,
                                    msg: "password is not matched");
                              }
                            }
                            authController.isLoading(false);
                          },
                          bgColor: _isChecked == false ? lightGrey : redColor,
                          textColor: whiteColor,
                          title: signup,
                        ).box.width(context.screenWidth - 50).make();
                      }),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyHaveAccount.text
                              .color(fontGrey)
                              .fontFamily(bold)
                              .make(),
                          InkWell(
                            onTap: () => Get.to(() => LoginScreen()),
                            child: login.text.underline
                                .color(redColor)
                                .fontFamily(bold)
                                .make(),
                          )
                        ],
                      ),
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
        ),
      ),
    );
  }
}
