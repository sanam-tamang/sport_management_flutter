import 'package:flutter/material.dart';
import 'package:sport_management/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _userName;
  late TextEditingController _password;
  String? _imageUrl;
  @override
  void initState() {
    _userName = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

//disposing value after going text page or either
//closing the page
  @override
  void dispose() {
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 24,
              ),
              //TODO: need to implemeted images and image picker later
              _imageUrl == null
                  ? CircleAvatar(
                      radius: 90,
                      backgroundColor: Theme.of(context).primaryColor,
                    )
                  : CircleAvatar(
                      radius: 90,
                    ),

              const SizedBox(
                height: 44,
              ),
              //userName controller
              setLoginFormController(
                  text: 'Username',
                  controller: _userName,
                  prefixIcon: Icons.person),
              const SizedBox(
                height: 24,
              ),
              setLoginFormController(
                  text: 'Password',
                  controller: _password,
                  prefixIcon: Icons.password_outlined,
                  obscureText: true),
              //Login Button
              const SizedBox(
                height: 24,
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
                    onPressed: () {
                      //what pushReplacement does that
                      //it does not shows the leading arrow from next page and
                      //it does not back again when user press the back button
                      //what  we can say that it will dispose the previous route

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => const HomePage())));
                    },
                    child: const Text("Login")),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

//making resualbe loginformcontroller
//
Widget setLoginFormController(
    {required String text,
    required TextEditingController controller,
    IconData? prefixIcon,
    bool obscureText = false}) {
  //BuilderClass for the context
  return Builder(builder: (context) {
    //TODO: need to work on keyboard fields
    //TODO: prefixIcon color
    //TODO: Form validation

    return Form(
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: text,
          prefixIcon: Icon(prefixIcon, color: Theme.of(context).primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  });
}
