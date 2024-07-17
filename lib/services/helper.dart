import 'package:http/http.dart' as http;
import 'package:pet_gear_pro/services/config.dart';
import 'package:pet_gear_pro/models/product_model.dart';

class Helper {
  static var client = http.Client();
  //Dog
  Future<List<Products>> getDogProducts() async {
    var url = Uri.http(Config.apiUrl, Config.UnSignin);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var dogList = productsFromJson(response.body);
      var dog = dogList.where((element) => element.category == "Dog Food");
      return dog.toList();
    } else {
      throw Exception('Failed to load jobs list');
    }
  }

  //Cat
  Future<List<Products>> getCatProducts() async {
    var url = Uri.http(Config.apiUrl, Config.UnSignin);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var catList = productsFromJson(response.body);
      var cat = catList.where((element) => element.category == "Cat Food");
      return cat.toList();
    } else {
      throw Exception('Failed to load jobs list');
    }
  }

  //Other
  Future<List<Products>> getOrtherProducts() async {
    var url = Uri.http(Config.apiUrl, Config.UnSignin);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var ortherList = productsFromJson(response.body);
      var orther = ortherList.where((element) => element.category == "Gear");
      return orther.toList();
    } else {
      throw Exception('Failed to load jobs list');
    }
  }

  Future<List<Products>> search(String searchQuery) async {
    var url = Uri.http(Config.apiUrl, Config.UnSignin);

    if(searchQuery!=''){
      print(searchQuery);
       url = Uri.http(Config.apiUrl, Config.UnSignin, {'search': searchQuery});
    }

    var response = await client.get(url);


    if (response.statusCode == 200||response.statusCode == 201) {
      var results = productsFromJson(response.body);

      return results;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
