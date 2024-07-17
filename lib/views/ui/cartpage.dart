import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pet_gear_pro/controllers/cart_provider.dart';
import 'package:pet_gear_pro/controllers/payment_provider.dart';
import 'package:pet_gear_pro/models/cart/get_products.dart';
import 'package:pet_gear_pro/models/orders/orders_req.dart';
import 'package:pet_gear_pro/services/cart_helper.dart';
import 'package:pet_gear_pro/services/payment_helper.dart';
import 'package:pet_gear_pro/views/shared/appstyle.dart';
import 'package:pet_gear_pro/views/shared/checkout_btn.dart';
import 'package:pet_gear_pro/views/shared/reusable_text.dart';
import 'package:pet_gear_pro/views/ui/payment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth_response/profile_model.dart';
import '../../services/auth_helper.dart';

// CartPage.dart

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<dynamic> _cartList;
  List<ProductItem>? checkout;
  bool? isSelected = true;
  bool? isLogged;

  @override
  void initState() {
    super.initState();
    _cartList = CartHelper.getCart();
  }

  @override
  Widget build(BuildContext context) {
    var paymentNotifier = Provider.of<PaymentNotifier>(context);
    var cartProvider = Provider.of<CartProvider>(context);
    return paymentNotifier.paymentUrl.contains("https")
        ? const PaymentWebView()
        : Scaffold(
            backgroundColor: const Color(0xFFE2E2E2),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          AntDesign.close,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "My Cart",
                        style: appstyle(36, Colors.black, FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: FutureBuilder(
                            future: _cartList,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
                              } else if (snapshot.hasError ||
                                  !snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(
                                  child: ReusableText(
                                    text:
                                        "There Nothing Here. Let's Buy SomeThing",
                                    style: appstyle(
                                        18, Colors.black, FontWeight.bold),
                                  ),
                                );
                              } else {
                                final products = snapshot.data!;
                                checkout = products;
                                return ListView.builder(
                                    itemCount: products!.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final data = products[index];

                                      return GestureDetector(
                                        onTap: () {
                                          cartProvider
                                              .toggleCheckOutProduct(data);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12)),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.11,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors
                                                            .grey.shade500,
                                                        spreadRadius: 5,
                                                        blurRadius: 0.3,
                                                        offset:
                                                            const Offset(0, 1)),
                                                  ]),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          Padding(
<<<<<<< HEAD
                                                            padding: const EdgeInsets.all(12),
                                                            child: CachedNetworkImage(
                                                              imageUrl: data.product.imageUrl[0].imageUrl,
=======
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: data
                                                                  .product
                                                                  .imageUrl[0]
                                                                  .imageUrl,
>>>>>>> 5f99aaeba6c24b1036ffb69467ebde6cbb00c91c
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: -2,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  cartProvider
                                                                      .toggleCheckOutProduct(
                                                                          data);
                                                                });
                                                              },
                                                              child: SizedBox(
                                                                height: 30.h,
                                                                width: 30.w,
                                                                child: Icon(
                                                                  cartProvider
                                                                          .getCheckOutList
                                                                          .contains(
                                                                              data)
                                                                      ? Feather
                                                                          .check_square
                                                                      : Feather
                                                                          .square,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                              bottom: -2,
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await CartHelper
                                                                      .deleteItem(
                                                                          data.id);
                                                                  setState(() {
                                                                    _cartList =
                                                                        CartHelper
                                                                            .getCart();
                                                                  });
                                                                  if (await CartHelper
                                                                          .getCart()
                                                                      .then((cart) =>
                                                                          cart.isEmpty)) {
                                                                    cartProvider
                                                                        .clearCart();
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 30,
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                              topRight: Radius.circular(12))),
                                                                  child:
                                                                      const Icon(
                                                                    AntDesign
                                                                        .delete,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 12,
                                                                left: 20),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              data.product.name,
<<<<<<< HEAD
                                                              style: appstyle(16, Colors.black, FontWeight.bold),
=======
                                                              style: appstyle(
                                                                  16,
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold),
>>>>>>> 5f99aaeba6c24b1036ffb69467ebde6cbb00c91c
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
<<<<<<< HEAD
                                                              data.product.category,
                                                              style: appstyle(14, Colors.grey, FontWeight.w600),
=======
                                                              data.product
                                                                  .category,
                                                              style: appstyle(
                                                                  14,
                                                                  Colors.grey,
                                                                  FontWeight
                                                                      .w600),
>>>>>>> 5f99aaeba6c24b1036ffb69467ebde6cbb00c91c
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
                                                                  "${double.parse(data.product.price) * cartProvider.getQuantity(data.product)} \VNĐ",
<<<<<<< HEAD
                                                                  style: appstyle(18, Colors.black, FontWeight.w600),
=======
                                                                  style: appstyle(
                                                                      18,
                                                                      Colors
                                                                          .black,
                                                                      FontWeight
                                                                          .w600),
>>>>>>> 5f99aaeba6c24b1036ffb69467ebde6cbb00c91c
                                                                ),
                                                                const SizedBox(
                                                                  width: 30,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          16))),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
<<<<<<< HEAD
                                                                    cartProvider.decrementQuantity(data.product);
=======
                                                                    cartProvider
                                                                        .decrementQuantity(
                                                                            data.product);
>>>>>>> 5f99aaeba6c24b1036ffb69467ebde6cbb00c91c
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    AntDesign
                                                                        .minussquare,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .grey,
                                                                  )),
                                                              Text(
<<<<<<< HEAD
                                                                cartProvider.getQuantity(data.product).toString(),
=======
                                                                cartProvider
                                                                    .getQuantity(
                                                                        data.product)
                                                                    .toString(),
>>>>>>> 5f99aaeba6c24b1036ffb69467ebde6cbb00c91c
                                                                style: appstyle(
                                                                  16,
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .w600,
                                                                ),
                                                              ),
                                                              InkWell(
                                                                  onTap: () {
<<<<<<< HEAD
                                                                    cartProvider.incrementQuantity(data.product);
=======
                                                                    cartProvider
                                                                        .incrementQuantity(
                                                                            data.product);
>>>>>>> 5f99aaeba6c24b1036ffb69467ebde6cbb00c91c
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    AntDesign
                                                                        .plussquare,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .black,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }),
                      )
                    ],
                  ),
                  cartProvider.getCheckOutList.isNotEmpty
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: CheckoutButton(
                              onTap: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String userId = prefs.getString('userId') ?? "";
<<<<<<< HEAD
                                ProfileRes profile = await AuthHelper.getProfile();
=======
                                ProfileRes profile =
                                    await AuthHelper.getProfile();
>>>>>>> 5f99aaeba6c24b1036ffb69467ebde6cbb00c91c

                                print(profile.id);
                                print('${cartProvider.getCheckOutList.length}');

                                Order model = Order(
                                    userId: userId,
                                    cartItems: cartProvider.getCheckOutList
                                        .map((product) => CartItemABC(
                                              name: product.product.name,
                                              id: product.productId,
                                              price: product.product.price,
<<<<<<< HEAD
                                              cartQuantity: cartProvider.getQuantity(product.product),
                                            ))
                                        .toList());
                                PaymentHelper.payment(model).then((value) async {
=======
                                              cartQuantity: cartProvider
                                                  .getQuantity(product.product),
                                            ))
                                        .toList());
                                PaymentHelper.payment(model)
                                    .then((value) async {
>>>>>>> 5f99aaeba6c24b1036ffb69467ebde6cbb00c91c
                                  // print(model.toJson());
                                  paymentNotifier.paymentUrl = value;
                                  // print(paymentNotifier.paymentUrl);
                                  Map<String, dynamic> data = {
                                    "userId": profile.id,
                                    "cartItems": cartProvider.getCheckOutList
                                        .map((product) => CartItemABC(
                                              name: product.product.name,
                                              id: product.productId,
                                              price: product.product.price,
<<<<<<< HEAD
                                              cartQuantity: cartProvider.getQuantity(product.product),
=======
                                              cartQuantity: cartProvider
                                                  .getQuantity(product.product),
>>>>>>> 5f99aaeba6c24b1036ffb69467ebde6cbb00c91c
                                            ))
                                        .toList(),
                                  };
                                  await CartHelper.createOrders(data);
                                });
                              },
                              label: "Proceed to Checkout"),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          );
  }
}
