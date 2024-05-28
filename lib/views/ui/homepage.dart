import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_gear_pro/views/shared/appstyle.dart';
import 'package:antd_mobile/antd_mobile.dart';
import 'package:pet_gear_pro/views/shared/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
              padding: const EdgeInsets.fromLTRB(10, 45, 0, 0),
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
                  top: MediaQuery.of(context).size.height * 0.265),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.405,
                          child: ListView.builder(
                              itemCount: 6,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return const ProductCard(
                                    price: "\$20.00",
                                    category: "Dog",
                                    id: "1",
                                    name: "Royal nud",
                                    image:
                                        "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg");
                              }),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(12, 20, 12, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Latest Product",
                                    style: appstyle(
                                        24, Colors.black, FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Show All",
                                        style: appstyle(
                                            22, Colors.black, FontWeight.w500),
                                      ),
                                      const Icon(
                                        AntIcons.rightOutline,
                                        size: 20,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.13,
                            child: ListView.builder(
                                itemCount: 6,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.white,
                                                  spreadRadius: 1,
                                                  blurRadius: 0.8,
                                                  offset: Offset(0, 1))
                                            ]),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                        )),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.405,
                          color: Colors.blue,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.405,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
