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

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Product>> _cartList;
  List<Product>? checkout;
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
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator.adaptive());
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: ReusableText(text: "NOTHING HERE, LET'S BUY SOME", style: appstyle(18, Colors.black, FontWeight.bold)),
                                );
                              } else {
                                final products = snapshot.data;
                                checkout = products;
                                return ListView.builder(
                                    itemCount: products!.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final data = products[index];

                                      return GestureDetector(
                                        onTap: () {
                                          cartProvider.toggleCheckOutProduct(data);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                                            child: Container(
                                              height: MediaQuery.of(context).size.height * 0.11,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(color: Colors.grey.shade100, boxShadow: [
                                                BoxShadow(color: Colors.grey.shade500, spreadRadius: 5, blurRadius: 0.3, offset: const Offset(0, 1)),
                                              ]),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(12),
                                                            child: CachedNetworkImage(
                                                              imageUrl: data.cartItem.imageUrl[0],
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: -2,
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  cartProvider.toggleCheckOutProduct(data);
                                                                });
                                                              },
                                                              child: SizedBox(
                                                                height: 30.h,
                                                                width: 30.w,
                                                                child: Icon(
                                                                  cartProvider.getCheckOutList.contains(data) ? Feather.check_square : Feather.square,
                                                                  size: 20,
                                                                  color: Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                              bottom: -2,
                                                              child: GestureDetector(
                                                                onTap: () async {
                                                                  await CartHelper.deleteItem(data.id);
                                                                  setState(() {
                                                                    _cartList = CartHelper.getCart();
                                                                  });
                                                                },
                                                                child: Container(
                                                                  width: 40,
                                                                  height: 30,
                                                                  decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.only(topRight: Radius.circular(12))),
                                                                  child: const Icon(
                                                                    AntDesign.delete,
                                                                    size: 20,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 12, left: 20),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              data.cartItem.name,
                                                              style: appstyle(16, Colors.black, FontWeight.bold),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              data.cartItem.category,
                                                              style: appstyle(14, Colors.grey, FontWeight.w600),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "\$${double.parse(data.cartItem.price) * cartProvider.getQuantity(data)}",
                                                                  style: appstyle(18, Colors.black, FontWeight.w600),
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
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    cartProvider.decrementQuantity(data);
                                                                  },
                                                                  child: const Icon(
                                                                    AntDesign.minussquare,
                                                                    size: 20,
                                                                    color: Colors.grey,
                                                                  )),
                                                              Text(
                                                                cartProvider.getQuantity(data).toString(),
                                                                style: appstyle(
                                                                  16,
                                                                  Colors.black,
                                                                  FontWeight.w600,
                                                                ),
                                                              ),
                                                              InkWell(
                                                                  onTap: () {
                                                                    cartProvider.incrementQuantity(data);
                                                                  },
                                                                  child: const Icon(
                                                                    AntDesign.plussquare,
                                                                    size: 20,
                                                                    color: Colors.black,
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
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                String userId = prefs.getString('userId') ?? "";
                                Order model = Order(
                                    userId: userId,
                                    cartItems: cartProvider.getCheckOutList
                                        .map((product) => CartItem(
                                              name: product.cartItem.name,
                                              id: product.cartItem.id,
                                              price: product.cartItem.price,
                                              cartQuantity: cartProvider.getQuantity(product),
                                            ))
                                        .toList());
                                PaymentHelper.payment(model).then((value) {
                                  paymentNotifier.paymentUrl = value;
                                  print(paymentNotifier.paymentUrl);
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
