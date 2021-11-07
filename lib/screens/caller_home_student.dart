import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coure_reg_admin/models/requests.dart';
import 'package:coure_reg_admin/models/student.dart';
import 'package:coure_reg_admin/screens/profile.dart';
import 'package:coure_reg_admin/screens/show_requests.dart';
import 'package:coure_reg_admin/service/auth.dart';
import 'package:coure_reg_admin/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CallerHomeStudent extends StatefulWidget {
  @override
  _CallerHomeStudentState createState() => _CallerHomeStudentState();
}

class _CallerHomeStudentState extends State<CallerHomeStudent> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String leaveTopic, userName, leaveReason;
  DateTime selectedDate = DateTime.now();

  final leaveTopicController = TextEditingController();
  final leaveReasonController = TextEditingController();
  final noOfDaysController = TextEditingController();

  CollectionReference studentList =
      FirebaseFirestore.instance.collection('studentList');

  List<Request> presentRequests = [];

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String tutorName;
  int semester = null;
  String courseName;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Student>(context);
    // DatabaseService dbService = DatabaseService(uid: user.uid);
    String userUid = user.name;
    CollectionReference studentList =
        FirebaseFirestore.instance.collection('studentList');

    final String displayName = userUid.substring(0, userUid.length - 11);
    DatabaseService dbService = new DatabaseService(uid: user.uid);
    int noOfDays;

    return SafeArea(
      child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Log Out'),
                        leading: Icon(Icons.arrow_back_ios),
                        onTap: () async {
                          await _auth.signOut();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Course Selector'),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Card(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Welcome,',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'admin!',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.center,
                              validator: (val) =>
                                  val.isEmpty ? 'Please enter an email' : null,
                              onChanged: (value) {
                                courseName = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter courseName',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'Search',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                color: Colors.lightBlue,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: studentList
                          .where('currentCourse', isEqualTo: courseName)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: Text('Loading'));
                        }

                        if (snapshot.data.docs.length == 0) {
                          return Center(
                              child: Text('No students opted this course'));
                        }

                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return GestureDetector(
                              child: Card(
                                borderOnForeground: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${document.get('name')}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              onTap: () {
                                print(
                                    "choose this course as current course ${document.get('courseName')}");
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
