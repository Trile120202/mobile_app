import 'package:flutter/material.dart';
import 'package:pet_gear_pro/controllers/mainscreen_provider.dart';
import 'package:pet_gear_pro/views/ui/cartpage.dart';
import 'package:pet_gear_pro/views/ui/homepage.dart';
import 'package:pet_gear_pro/views/ui/searchpage.dart';
import 'package:pet_gear_pro/views/ui/profile.dart';
import 'package:pet_gear_pro/views/shared/bottom_nav.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key});

  List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    HomePage(),
    CartPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
