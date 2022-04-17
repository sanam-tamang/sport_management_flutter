import 'dart:convert';

import 'dart:io';
import 'package:http/http.dart' as http;

import '../exception_class/custome_exception.dart';

Future postTakenProductData({
  required String studentID,
  required String studentName,
  required String studentFaculty,
  required String takenProduct,
}) async {
  DateTime _currentDate = DateTime.now();
  String date =
      "${_currentDate.year}/${_currentDate.month}/${_currentDate.day}";
  try {
    final uri = Uri.https('sanamtamang.com.np',
        'backend_practice_4.0_sport_management/post_taken_product_data.php');
    final _body = {
      'studentID': studentID,
      'studentName': studentName,
      'studentFaculty': studentFaculty,
      'takenProduct': takenProduct,
      'date': date
    };
    final response = await http.post(uri, body: _body);

    if (response.statusCode == 200) {
      // log("successfully posted data I am in post method");
      // log(response.body);

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
