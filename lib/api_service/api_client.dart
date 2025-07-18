import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shoping_app/api_service/Model/product_model.dart';

// "email": "eve.holt@reqres.in",
// "password": "cityslicka"

class ApiClient {
  Future<dynamic> userLogIn(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse("https://reqres.in/api/login"),
        body: jsonEncode({"email": email, "password": password,}),
        headers: {"Content-Type": "application/json", "x-api-key": "reqres-free-v1",},
      );

      if (response.statusCode == 200) {
        final token = jsonDecode(response.body);
        print("Response Body: ${response.body}");
        print("Token : $token");

        return token; // ✅ RETURN AFTER PRINT
      } else {
        print("Error : ${response.statusCode}");
        print("Body: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    return null;
  }




  Future<ProductModel?> getProducts() async {
    try {
      var response = await http.get(Uri.parse("https://dummyjson.com/products"),);

      if (response.statusCode == 200) {
       ProductModel productModel = ProductModel.fromJson(jsonDecode(response.body));
        return productModel;
      } else {
        print("Error : ${response.statusCode}");
        print("Body: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    return null;
  }
}
