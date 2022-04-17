import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sport_management/model/taken_product_data_model.dart';

import '../exception_class/custome_exception.dart';

Future getTakenProductData() async {
  try {
    final uri = Uri.https('sanamtamang.com.np',
        'backend_practice_4.0_sport_management/get_taken_product_data.php');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      var hasData = decodedData['hasData'];
      var data = decodedData['data'];
      if (hasData == true) {
        var student = List.from(data).map((e) => Student.fromJson(e)).toList();
        return student;
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
