import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//making resuable textformfield
//and passing value and controller according to the data

Widget setTextFormField(
    {String? Function(String? value)? validator,
    required String text,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    int? maxLines = 1}) {
  return Builder(builder: (context) {
    return TextFormField(
      autocorrect: false,
      enableSuggestions: true,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        // floatingLabelStyle: TextStyle(color: Theme.of(context).focusColor),
        labelText: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Theme.of(context).focusColor)),
      ),
    );
  });
}
