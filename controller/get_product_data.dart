import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sport_management/exception_class/custome_exception.dart';
import 'package:sport_management/model/product.dart';

Future getProductData() async {
  try {
    final uri = Uri.https('sanamtamang.com.np',
        'backend_practice_4.0_sport_management/get_product_data.php');

    final response = await http.get(uri);
    //making instance of response for the catch field

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      // ***************** for converting list data ******************
      //product model

      // print(decodedData);
      //**************List of Map data is coming from api so converting them */
      final data = decodedData["data"];
      final hasData = decodedData["hasData"];

      //if data has in the database
      if (hasData == true) {
        final product =
            List.from(data).map<Product>((e) => Product.fromJson(e)).toList();
        return product;
      } else {
        //if doesnot have the data
        return null;
      }
    }
    //socketException is simply throws error when no interent in the device
  } on SocketException {
    throw CustomeSocketException();
    //httpException occurs when not found or 404 error occur
  } on HttpException {
    throw CustomeHttpException();
    //formatException is jsonFormat Exception
  } on FormatException {
    throw CustomeFormatException();
  } catch (e) {
    //if there is uncounse exception out there
    throw const Failure("Something went wrong");
  }
}
