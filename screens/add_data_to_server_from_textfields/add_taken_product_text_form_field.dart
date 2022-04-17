import 'package:flutter/material.dart';
import 'package:sport_management/controller/post_taken_product_data.dart';
import 'package:sport_management/reuable_widgets/reuable_text_form_field.dart';
import 'package:sport_management/reuable_widgets/reusable_snackbar.dart';

class StudentTextFormFieldWidget extends StatefulWidget {
  const StudentTextFormFieldWidget({Key? key}) : super(key: key);

  @override
  State<StudentTextFormFieldWidget> createState() =>
      _StudentTextFormFieldWidgetState();
}

class _StudentTextFormFieldWidgetState
    extends State<StudentTextFormFieldWidget> {
  late TextEditingController _studentName;
  late TextEditingController _studentID;
  late TextEditingController _studentFaculty;
  //item name is simply the product like football , basket ball , etc which students
  //take from college
  late TextEditingController _takenProduct;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _studentName = TextEditingController();
    _studentID = TextEditingController();
    _studentFaculty = TextEditingController();
    _takenProduct = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _studentID.dispose();
    _studentName.dispose();
    _studentFaculty.dispose();
    _takenProduct.dispose();
    super.dispose();
  }

  validate() async {
    if (formKey.currentState!.validate()) {
      // log("yadii form chaii right vayo vane ");
      // log((formKey.currentState!.validate().toString()));```````````````````````````````````````````````````````````````````````

      var isSent = await postTakenProductData(
          studentID: _studentID.text,
          studentName: _studentName.text,
          studentFaculty: _studentFaculty.text,
          takenProduct: _takenProduct.text);

      // log("Hello hello heloo");
      // log(isSent.runtimeType.toString());
      //if sent data is is successfully inserted to the DB
      if (isSent == true) {
        reusableSnackBar(
            context: context,
            contentText: "Inserted taken product successfully");
        //yadi data insert vayo vane matra pop gareara previous page maa
        // janxa navaye jadaina
        //pop garda kina delay rakheko vanda snackbar tehii page maa matra show garos
        //next page maa show nagaross vnnu ko laagi gareko
        //keyboard laiii unfocus gareko
        FocusScope.of(context).unfocus();
        await Future.delayed(const Duration(milliseconds: 1200), (() {
          Navigator.pop(context);
        }));
      } else {
        reusableSnackBar(
            context: context,
            contentText: isSent == false
                ? "Make sure you have entered right character"
                : "$isSent");
      }
    } else {
      // log("hyadii form galat vayo ya form validation le vaneko kura pura vayena vane");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            //form is for validate
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                //TODO: for circle later need to add image here2
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(150),
                      )),
                ),

                const SizedBox(
                  height: 45,
                ),
                //studentID or Roll no
                setTextFormField(
                    validator: validator,
                    text: 'Student\'s ID',
                    controller: _studentID),
                const SizedBox(
                  height: 15,
                ),
                //student  name
                setTextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Required *";
                      } else if (value.length < 4) {
                        return "Length must be greater than four";
                      } else if (value.length >= 21) {
                        return "Length must be less than 20 ";
                      } else if (!value.contains(RegExp(r'^[a-zA-Z ]+$'))) {
                        return "Name must contain characters";
                      } else if (value.contains(RegExp(r"(\s\s)"))) {
                        return "only one white space is allowed";
                      } else {
                        return null;
                      }
                    },
                    text: 'Student\'s Name',
                    controller: _studentName),
                const SizedBox(
                  height: 15,
                ),
                //student faculty
                setTextFormField(
                    validator: validator,
                    text: 'Student\'s Faculty',
                    controller: _studentFaculty),
                const SizedBox(
                  height: 15,
                ),
                //itemTaken
                setTextFormField(
                    validator: validateItems,
                    text: 'Item Name (eg. Football)',
                    controller: _takenProduct),
                const SizedBox(
                  height: 35,
                ),

                //submit button

                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 13)),
                    ),
                    //when onpress goes to validate form
                    onPressed: validate,
                    child: const Text("Submit"),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//validates all 3
String? validator(String? value) {
  if (value!.isEmpty) {
    return "Required *";
  } else if (value.length >= 21) {
    return "Length must be less than 20 ";
    //\s\s garepaxi
    //euta white space chaii allowed hunxa tyo vanda badi hudaina
    // \s garda euta panii white space allowed hudaina
  } else if (value.contains(RegExp(r"(\s\s)"))) {
    return "only one white space is allowed";
  } else {
    //yadii return null vayo vane
    //form validate hunxa
    return null;
  }
}

//validate takenProduct
String? validateItems(String? value) {
  if (value!.isEmpty) {
    return "Required *";
  } else if (value.length >= 40) {
    return "Length must be less than 40 ";
  } else if (value.contains(RegExp(r"(\s\s)"))) {
    return "only one white space is allowed";
  } else {
    //yadii return null vayo vane
    //form validate hunxa
    return null;
  }
}
