import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_gear_pro/models/product_model.dart';
import 'package:pet_gear_pro/views/shared/stagger_tile.dart';
import 'package:pet_gear_pro/views/ui/product_page.dart';

class latestProducts extends StatelessWidget {
  const latestProducts({
    super.key,
    required Future<List<Products>> dog,
  }) : _dog = dog;
  final Future<List<Products>> _dog;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Products>>(
        future: _dog,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final dog = snapshot.data;
            return StaggeredGridView.countBuilder(
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
                itemCount: dog!.length,
                scrollDirection: Axis.vertical,
                staggeredTileBuilder: (index) => StaggeredTile.extent(
                    (index % 2 == 0) ? 1 : 1,
                    (index % 4 == 1 || index % 4 == 3)
                        ? MediaQuery.of(context).size.height * 0.35
                        : MediaQuery.of(context).size.height * 0.305),
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage(
                                    products: item,
                                  )));
                    },
                    child: StaggerTile(
                        imageUrl: item.imageUrl[1],
                        name: item.name,
                        price: "\$${item.price}"),
                  );
                });
          }
        });
  }
}
