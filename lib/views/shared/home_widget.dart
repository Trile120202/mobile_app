import 'package:antd_mobile/antd_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:pet_gear_pro/controllers/product_provider.dart';
import 'package:pet_gear_pro/models/product_model.dart';
import 'package:pet_gear_pro/views/shared/appstyle.dart';
import 'package:pet_gear_pro/views/shared/new_products.dart';
import 'package:pet_gear_pro/views/shared/product_card.dart';
import 'package:pet_gear_pro/views/ui/product_by_cart.dart';
import 'package:pet_gear_pro/views/ui/product_page.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Products>> dog,
    required this.tabIndex,
  }) : _dog = dog;
  final Future<List<Products>> _dog;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.405,
            child: FutureBuilder<List<Products>>(
                future: _dog,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else {
                    final dog = snapshot.data;
                    return ListView.builder(
                        itemCount: dog!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                          id: item.id,
                                          category: item.category)));
                            },
                            child: ProductCard(
                              price: "\$${item.price}",
                              category: item.category,
                              id: item.id,
                              name: item.name,
                              image: item.imageUrl[0],
                            ),
                          );
                        });
                  }
                })),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Products",
                    style: appstyle(24, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductByCat(
                                    tabIndex: tabIndex,
                                  )));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: appstyle(22, Colors.black, FontWeight.w500),
                        ),
                        const Icon(
                          AntDesign.caretright,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
            child: FutureBuilder<List<Products>>(
                future: _dog,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else {
                    final dog = snapshot.data;
                    return ListView.builder(
                        itemCount: dog!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NewProducts(
                              imageUrl: item.imageUrl[1],
                            ),
                          );
                        });
                  }
                })),
      ],
    );
  }
}
