import 'package:e_mart_app/consts/consts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogoWidget(),
            10.heightBox,
            "Login into ${appname}".text.size(18).fontFamily(bold).white.make(),
            10.heightBox,
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
              ],
            ).box.white.rounded.p16.width(context.screenWidth - 30).make(),
          ],
        ),
      ),
    ));
  }
}
