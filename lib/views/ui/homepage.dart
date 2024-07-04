import 'package:flutter/material.dart';
import 'package:pet_gear_pro/models/product_model.dart';
import 'package:pet_gear_pro/services/helper.dart';
import 'package:pet_gear_pro/views/shared/appstyle.dart';
import 'package:pet_gear_pro/views/shared/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  late Future<List<Products>> _dog;
  late Future<List<Products>> _cat;
  late Future<List<Products>> _other;

  void getDog() {
    _dog = Helper().getDogProducts();
  }

  void getCat() {
    _cat = Helper().getCatProducts();
  }

  void getOther() {
    _other = Helper().getOrtherProducts();
  }

  @override
  void initState() {
    super.initState();
    getDog();
    getCat();
    getOther();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/petgear.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 8, bottom: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pet Gear Pro',
                      style: appstyleWHight(
                        42,
                        Colors.black,
                        FontWeight.bold,
                        1.5,
                      ),
                    ),
                    Text(
                      'Collection',
                      style: appstyleWHight(
                        42,
                        Colors.black,
                        FontWeight.bold,
                        1.2,
                      ),
                    ),
                    TabBar(
                        padding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelStyle: appstyle(
                          24,
                          Colors.white,
                          FontWeight.bold,
                        ),
                        unselectedLabelColor: Colors.grey.withOpacity(0.3),
                        tabs: const [
                          Tab(
                            text: "Product For Dogs",
                          ),
                          Tab(
                            text: "Product For Cats",
                          ),
                          Tab(
                            text: "Others",
                          )
                        ]),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(controller: _tabController, children: [
                  HomeWidget(
                    dog: _dog,
                    tabIndex: 0,
                  ),
                  HomeWidget(
                    dog: _cat,
                    tabIndex: 1,
                  ),
                  HomeWidget(
                    dog: _other,
                    tabIndex: 2,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
