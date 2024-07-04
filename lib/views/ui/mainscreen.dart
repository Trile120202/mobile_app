import 'package:flutter/material.dart';
import 'package:pet_gear_pro/controllers/login_provider.dart';
import 'package:pet_gear_pro/controllers/mainscreen_provider.dart';
import 'package:pet_gear_pro/views/ui/favorites.dart';
import 'package:pet_gear_pro/views/ui/homepage.dart';
import 'package:pet_gear_pro/views/ui/searchpage.dart';
import 'package:pet_gear_pro/views/ui/profile.dart';
import 'package:pet_gear_pro/views/shared/bottom_nav.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const Favorites(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    loginNotifier.getPrefs();
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
