import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:pet_gear_pro/controllers/favorites_provider.dart';
import 'package:pet_gear_pro/controllers/login_provider.dart';
import 'package:pet_gear_pro/views/shared/appstyle.dart';
import 'package:pet_gear_pro/views/ui/mainscreen.dart';
import 'package:pet_gear_pro/views/ui/non_user_page.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final _favBox = Hive.box('fav_box');

  _deleteCart(int key) async {
    await _favBox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    List<dynamic> fav = [];
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price']
      };
    }).toList();

    fav = favData.reversed.toList();
    return loginNotifier.loggedIn == false
        ? const NonUser()
        : Scaffold(
            backgroundColor: const Color(0xFFE2E2E2),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/petgear.png"),
                            fit: BoxFit.cover)),
                    child: Container(
                      margin: EdgeInsets.only(top: 20.h),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "My Favorites",
                        style: appstyle(36, Colors.white, FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 120),
                        itemCount: fav.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final products = fav[index];
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade500,
                                          spreadRadius: 5,
                                          blurRadius: 0.3,
                                          offset: const Offset(0, 1)),
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: CachedNetworkImage(
                                            imageUrl: products['imageUrl'],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12, left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                products['name'],
                                                style: appstyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                products['category'],
                                                style: appstyle(14, Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "\$ ${products['price']}",
                                                    style: appstyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          _deleteCart(products['key']);
                                          favoritesNotifier.ids.removeWhere(
                                              (element) =>
                                                  element == products['id']);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MainScreen()));
                                        },
                                        child: const Icon(
                                          Ionicons.md_heart_dislike,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Positioned(
                    top: 50.h,
                    left: 20.w,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        AntDesign.close,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
