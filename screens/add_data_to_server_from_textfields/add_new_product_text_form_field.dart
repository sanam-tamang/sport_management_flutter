import 'package:flutter/material.dart';
import 'package:sport_management/controller/post_product_data.dart';
import 'package:sport_management/reuable_widgets/reuable_text_form_field.dart';
import 'package:sport_management/reuable_widgets/reusable_snackbar.dart';

//add product
class ProductTextFormFieldWidget extends StatefulWidget {
  const ProductTextFormFieldWidget({Key? key}) : super(key: key);

  @override
  State<ProductTextFormFieldWidget> createState() =>
      _ProductTextFormFieldWidgetState();
}

//this screen is for the
//additing the product or items
//which came from the other places to the school or colleges

class _ProductTextFormFieldWidgetState
    extends State<ProductTextFormFieldWidget> {
  late TextEditingController _productColor;
  late TextEditingController _productName;
  late TextEditingController _productQuantity;
  late TextEditingController _productDescription;
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    _productColor = TextEditingController();
    _productName = TextEditingController();
    _productQuantity = TextEditingController();
    _productDescription = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _productName.dispose();
    _productQuantity.dispose();
    _productColor.dispose();
    _productDescription.dispose();
    super.dispose();
  }

  validateForm() async {
    if (productFormKey.currentState!.validate()) {
      //if validate value is true and can perform the later tasks
//isSent maa true or false matra naaayera
//dheraii chig aauxa
//return error panii aauxa anii

      var isSent = await postProductData(
          productName: _productName.text,
          productColor: _productColor.text,
          productQuantity: _productQuantity.text,
          productDescription: _productDescription.text);

      if (isSent == true) {
        reusableSnackBar(
            context: context, contentText: 'Inserted product successfully');
        //keyboard laiii unfocus gareko
        FocusScope.of(context).unfocus();
        await Future.delayed(const Duration(milliseconds: 1200), (() {
          Navigator.pop(context);
        }));
      }
//*** kin  hamile isSent==false ?"":"" gareko vanda yadi server le false pathayemaa
//yadii server le http aru kehii or internet connection or arukehii problemaa aayo vane
//isSent ko value farak hunxa tesaile testo gareko ho

      else {
        reusableSnackBar(
            context: context,
            contentText: isSent == false
                ? "Make sure you have entered right character"
                : "$isSent");
      }
    } else {
      ///####################################################
      ///###########################################
      //if validatation is false
      //or cannot fulfil the certain criteria
      //we do nothing here
      ///####################################
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: productFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                //product name
                setTextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Required *";
                      } else if (value.length < 4) {
                        return "Length must be greater than four";
                      } else if (value.length >= 30) {
                        return "Length must be less than 30 ";
                      } else if (!value.contains(RegExp(r'^[a-zA-Z ]+$'))) {
                        return "Product Name must contain characters";
                      } else if (value.contains(RegExp(r"(\s\s)"))) {
                        return "only one white space is allowed";
                      } else {
                        return null;
                      }
                    },
                    text: 'Product Name',
                    controller: _productName),
                const SizedBox(
                  height: 15,
                ),

                //product Color
                setTextFormField(
                    validator: validator,
                    text: 'Product Color',
                    controller: _productColor),

                const SizedBox(
                  height: 15,
                ),

                //product quantity
                setTextFormField(
                    validator: validator,
                    text: 'Product Quantity',
                    keyboardType: TextInputType.number,
                    controller: _productQuantity),

                const SizedBox(
                  height: 15,
                ),
                //product description
                setTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required *";
                      } else if (value.length < 4) {
                        return "length must be greater than 4";
                      } else if (value.length >= 101) {
                        return "Length must be less than 100";
                      } else if (value.contains(RegExp(r"(\s\s\s\s)"))) {
                        return "only three white space is allowed";
                      } else {
                        //yadii return null vayo vane
                        //form validate hunxa
                        return null;
                      }
                    },
                    text: 'Description',
                    controller: _productDescription,
                    maxLength: 100,
                    maxLines: 6),

                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 13)),
                    ),
                    onPressed: validateForm,
                    child: const Text(
                      "Insert Item",
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validator(String? value) {
  if (value!.isEmpty) {
    return "Required *";
  } else if (value.length >= 21) {
    return "Length must be less than 20 ";
  } else if (value.contains(RegExp(r"(\s\s)"))) {
    return "only one white space is allowed";
  } else if (!value.contains(RegExp(r'^[a-zA-Z0-9 ]+$'))) {
    return "Value must be aphabet or number";
  } else {
    //yadii return null vayo vane
    //form validate hunxa
    return null;
  }
}
