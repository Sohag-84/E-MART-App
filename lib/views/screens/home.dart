// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/home_controller.dart';
import 'package:e_mart_app/views/screens/categories_screen/categories_screen.dart';
import 'package:e_mart_app/views/screens/home_screen/home_screen.dart';

import 'cart_screen.dart';
import 'profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final _homeController = Get.put(HomeController());

  var pageList = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var navbarItem = [
      BottomNavigationBarItem(
        icon: Image.asset(
          icHome,
          width: 26,
        ),
        label: home,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCategories,
          width: 26,
        ),
        label: categories,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCart,
          width: 26,
        ),
        label: cart,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icProfile,
          width: 26,
        ),
        label: account,
      ),
    ];
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: redColor,
          selectedLabelStyle: TextStyle(fontFamily: semibold),
          backgroundColor: whiteColor,
          currentIndex: _homeController.currentNavIndex.value,
          onTap: (value) {
            _homeController.currentNavIndex.value = value;
          },
          items: navbarItem,
        ),
        body: pageList[_homeController.currentNavIndex.value],
      );
    });
  }
}
