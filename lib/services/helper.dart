import 'package:flutter/services.dart';
import 'package:pet_gear_pro/models/product_model.dart';

class Helper {
  //Dog
  Future<List<Products>> getDogProducts() async {
    final data = await rootBundle.loadString("assets/json/dog.json");
    final dogList = productsFromJson(data);
    return dogList;
  }

  //Cat
  Future<List<Products>> getCatProducts() async {
    final data = await rootBundle.loadString("assets/json/cat.json");
    final catList = productsFromJson(data);
    return catList;
  }

  //Other
  Future<List<Products>> getOrtherProducts() async {
    final data = await rootBundle.loadString("assets/json/other.json");
    final ortherList = productsFromJson(data);
    return ortherList;
  }

  //Single Cat
  Future<Products> getCatProductsById(String id) async {
    final data = await rootBundle.loadString("assets/json/cat.json");
    final catList = productsFromJson(data);
    final cat = catList.firstWhere((cat) => cat.id == id);
    return cat;
  }

  //Single Dog
  Future<Products> getDogProductsById(String id) async {
    final data = await rootBundle.loadString("assets/json/dog.json");
    final dogList = productsFromJson(data);
    final dog = dogList.firstWhere((dog) => dog.id == id);
    return dog;
  }

  //Another
  Future<Products> getOtherProductsById(String id) async {
    final data = await rootBundle.loadString("assets/json/other.json");
    final otList = productsFromJson(data);
    final orther = otList.firstWhere((orther) => orther.id == id);
    return orther;
  }
}
