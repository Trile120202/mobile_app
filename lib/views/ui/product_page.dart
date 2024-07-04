import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:pet_gear_pro/controllers/favorites_provider.dart';
import 'package:pet_gear_pro/controllers/login_provider.dart';
import 'package:pet_gear_pro/controllers/product_provider.dart';
import 'package:pet_gear_pro/models/cart/add_to_cart.dart';
import 'package:pet_gear_pro/models/product_model.dart';
import 'package:pet_gear_pro/services/cart_helper.dart';
import 'package:pet_gear_pro/services/helper.dart';
import 'package:pet_gear_pro/views/shared/appstyle.dart';
import 'package:pet_gear_pro/views/shared/checkout_btn.dart';
import 'package:pet_gear_pro/views/ui/auth/login.dart';
import 'package:pet_gear_pro/views/ui/favorites.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.products});

  final Products products;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');
  final _favBox = Hive.box('fav_box');

  Future<void> _createCart(Map<dynamic, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  Future<void> _createFav(Map<dynamic, dynamic> addFav) async {
    await _favBox.add(addFav);
    getFavorites();
  }

  getFavorites() {
    var favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: false);
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
      };
    }).toList();
    favoritesNotifier.favorites = favData.toList();
    favoritesNotifier.ids =
        favoritesNotifier.favorites.map((item) => item['id']).toList();
  }

  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(body: Consumer<ProductNotifier>(
      builder: (context, productNotifier, child) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leadingWidth: 0,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        AntDesign.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              pinned: true,
              snap: false,
              floating: true,
              backgroundColor: Colors.transparent,
              expandedHeight: MediaQuery.of(context).size.height,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.products.imageUrl.length,
                          controller: pageController,
                          onPageChanged: (page) {
                            productNotifier.activePage = page;
                          },
                          itemBuilder: (context, int index) {
                            return Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.39,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey.shade300,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.products.imageUrl[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Positioned(
                                    top: 56.h,
                                    right: 20.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (loginNotifier.loggedIn == true) {
                                          if (favoritesNotifier.ids
                                              .contains(widget.products.id)) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Favorites()));
                                          } else {
                                            _createFav({
                                              "id": widget.products.id,
                                              "name": widget.products.name,
                                              "category":
                                                  widget.products.category,
                                              "imageUrl":
                                                  widget.products.imageUrl[0],
                                              "price": widget.products.price,
                                            });
                                          }
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage()));
                                        }
                                      },
                                      child: favoritesNotifier.ids
                                              .contains(widget.products.id)
                                          ? const Icon(AntDesign.heart)
                                          : const Icon(AntDesign.hearto),
                                    )),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List<Widget>.generate(
                                          widget.products.imageUrl.length,
                                          (index) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                child: CircleAvatar(
                                                  radius: 5,
                                                  backgroundColor:
                                                      productNotifier
                                                                  .activepage !=
                                                              index
                                                          ? Colors.grey
                                                          : Colors.black,
                                                ),
                                              )),
                                    )),
                              ],
                            );
                          }),
                    ),
                    Positioned(
                        bottom: 30,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.645,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.products.name,
                                    maxLines: 1,
                                    style: appstyle(
                                        40, Colors.black, FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.products.category,
                                        style: appstyle(
                                            20, Colors.grey, FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      RatingBar.builder(
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 22,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${widget.products.price}",
                                        style: appstyle(
                                            26, Colors.black, FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    indent: 10,
                                    endIndent: 10,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      widget.products.title,
                                      maxLines: 2,
                                      style: appstyle(
                                          26, Colors.black, FontWeight.w700),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.products.description,
                                    textAlign: TextAlign.justify,
                                    maxLines: 4,
                                    style: appstyle(
                                        14, Colors.black, FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: CheckoutButton(
                                        onTap: () async {
                                          if (loginNotifier.loggedIn == true) {
                                            AddToCart model = AddToCart(
                                                cartItem: widget.products.id,
                                                quantity: 1);
                                            CartHelper.addToCart(model);
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage()));
                                          }
                                        },
                                        label: "Add to Cart",
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
