import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sport_management/exception_class/custome_exception.dart';

Future postProductData(
    {required String productName,
    required String productColor,
    required String productQuantity,
    required String productDescription}) async {
  DateTime _currentDate = DateTime.now();
  String date =
      "${_currentDate.year}/${_currentDate.month}/${_currentDate.day}";
  try {
    final uri = Uri.https('sanamtamang.com.np',
        'backend_practice_4.0_sport_management/post_product_data.php');
    final _body = {
      'productName': productName,
      'productQuantity': productQuantity,
      'productDescription': productDescription,
      'productColor': productColor,
      'date': date
    };
    final response = await http.post(uri, body: _body);
    // var rawData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var getDecodedData = jsonDecode(response.body);
      var isSent = getDecodedData['isSent'];
      return isSent;
    }
    //socketException is simply throws error when no interent in the device
    //############
    //IMplemented return instead of throw
    //kina vane hamro return futureBuilder or
    //streambuilder xaina tesaile errror
    //handling laagi kehii navayeko karanle yesto gareko ho
    //#################################
    ///
  } on SocketException {
    return CustomeSocketException();
    //httpException occurs when not found or 404 error occur
  } on HttpException {
    return CustomeHttpException();
    //formatException is jsonFormat Exception
  } on FormatException {
    return CustomeFormatException();
  } catch (e) {
    //if there is uncounse exception out there
    return const Failure("Something went wrong");
  }
}
