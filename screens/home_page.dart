import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_management/controller/get_product_data.dart';
import 'package:sport_management/provider/small_change_variable_provider.dart';

import 'add_data_to_server_from_textfields/add_new_product_text_form_field.dart';
import 'add_data_to_server_from_textfields/add_taken_product_text_form_field.dart';
import 'home_page_screen_children/show_product_data.dart';
import 'home_page_screen_children/show_taken_product_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _listOfWidges = const [
    ShowProduct(),
    ShowTakenProduct(),
  ];

  final List<String> _listOfString = const ["Sport Items", "Taken Items"];

  @override
  Widget build(BuildContext context) {
    int index = Provider.of<SmallValueChangerProvider>(context).homeIndex;
    return Scaffold(
      appBar: AppBar(
        title: Text(_listOfString[index]),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      extendBody: true,
      body: _listOfWidges[index],
      bottomNavigationBar: bottomNavigationBa(context, index),
      floatingActionButton: floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: drawer(BuildContext),
    );
  }
}

/// Home Pages widges only/

Widget bottomNavigationBa(BuildContext context, int index) {
  return BottomAppBar(
    shape: const CircularNotchedRectangle(),
    elevation: 0,
    color: Colors.white,
    child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.grey.withAlpha(0),
        currentIndex: index,
        onTap: Provider.of<SmallValueChangerProvider>(context, listen: false)
            .changeHomeIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard_customize_outlined,
              ),
              label: 'Sport Items'),
          BottomNavigationBarItem(
              icon: Icon(Icons.workspaces_outlined), label: 'Taken Items'),
        ]),
  );
}

//floating action button
Widget floatingActionButton(BuildContext context) {
  return FloatingActionButton(
    backgroundColor: Theme.of(context).primaryColor.withGreen(20),
    foregroundColor: Colors.white,
    onPressed: () {
      showDialog(
          context: (context),
          builder: (BuildContext context) {
            return GestureDetector(
              onDoubleTap: () => Navigator.of(context).pop(),
              child: AlertDialog(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            //this pops the alerts dialog when click this page
                            Navigator.of(context).pop();
                            //goes to product page
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) =>
                                    const ProductTextFormFieldWidget())));
                          },
                          child: const Text("Add Items")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) =>
                                    const StudentTextFormFieldWidget())));
                          },
                          child: const Text("Add Taken Item")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            //TODO: later implement of received item
                          },
                          child: const Text("Add Received Item")),
                    ],
                  ),
                ),
              ),
            );
          });
    },
    child: const Icon(Icons.add),
  );
}

//TODO: todo drawer implementation
Widget drawer(BuildContext) {
  return Drawer(
   
  );
}
