import 'package:flutter/material.dart';

import 'package:sport_management/controller/get_product_data.dart';
import 'package:sport_management/controller/get_taken_product_data.dart';
import 'package:sport_management/model/product.dart';

import '../../model/taken_product_data_model.dart';

class ShowTakenProduct extends StatefulWidget {
  const ShowTakenProduct({Key? key}) : super(key: key);

  @override
  State<ShowTakenProduct> createState() => _ShowTakenProductState();
}

class _ShowTakenProductState extends State<ShowTakenProduct> {
  @override
  Widget build(BuildContext context) {
    //for retrieving the data

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Container(
        color: Colors.grey[200],
        child: FutureBuilder(
          future: getTakenProductData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );

              ///**********ConnectionState is done  start **************/
              case ConnectionState.done:
                if (snapshot.hasData) {
                  //################ if api returned the dat #############
                  //###################we willl show the data herer ##############################
                  return TakenProductData(
                      student: snapshot.data as List<Student>);
                } else if (snapshot.hasError) {
                  rebuildErrorCall();
                  return Center(
                      child: Text(
                    "${snapshot.error}",
                  ));
                } else {
                  return const Center(
                      child: Text(
                    'No data found please add the data',
                  ));
                }
              /*******Connection state done end */

              default:
                /**********************it is just for checking purpose */
                return const Center(
                    child: Text(
                  "Wait a sec..",
                ));
            }
          },
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {});
  }

  ///if builder the hits the error
  /// yadii error aayo vane future builder mam
  /// //error j panii hunu sakxa
  /// In every 5 second maa chaii yesle chaii call gari raheko hunxa
  /// anii as soon as yesle chaii net pauxa tab yesle data show garnu thalxa
  /// yani kii yo chaii maily vaneko yadii no internet connection vanera aayo vane
  /// error hit garo anii tesko laagi yo code lekheko ho
  /// every 5 second maa chaii yesle aafulaii rebuild garera data process gaross vanera
  Future rebuildErrorCall() async {
    // log("hello bro 0 se");
    await Future.delayed(const Duration(seconds: 5));
    setState(() {});
    // log("hello bro 5 se");
  }
}

//#############

//  *** Product Data basically shows the fetched from the api or database   //

//############
class TakenProductData extends StatelessWidget {
  const TakenProductData({Key? key, required this.student}) : super(key: key);
  final List<Student> student;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: student.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withRed(255),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 10,
                  spreadRadius: -5,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          student[index].studentID,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Spacer(),
                        Text(
                          ' ${student[index].date}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          student[index].studentName,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const Spacer(),
                        Text(
                          student[index].takenProduct,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey[200]),
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => ShowFullTakenProductData(
                                  student: student[index]))));
                        },
                        child: const Text('view all')),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

/** THis shows data after clicking the view all button */
class ShowFullTakenProductData extends StatelessWidget {
  final Student student;
  const ShowFullTakenProductData({Key? key, required this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ID: ${student.studentID}')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Name: ${student.studentName}'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Faculty: ${student.studentFaculty}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Taken Product: ${student.takenProduct}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Taken Product: ${student.date}',
          ),
        ),
      ]),
    );
  }
}
