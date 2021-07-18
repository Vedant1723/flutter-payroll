import 'package:flutter/material.dart';
import 'package:payroll/components/Auth/LoginPage.dart';
import 'package:payroll/components/Employees/AddEmployee.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:payroll/components/Employees/ManageEmployee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Employees extends StatefulWidget {
  const Employees({Key? key}) : super(key: key);

  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  String search = "";
  GlobalKey<FormState> _key = new GlobalKey();
  Timer? timer;
  SharedPreferences? prefs;

  String? token;

  List employees = [];

  @override
  void initState() {
    super.initState();
    initializePreference();
    getEmplyees();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => getEmplyees());
  }

  Future<void> initializePreference() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs?.getString("token");
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              prefs?.clear();

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()));
            },
          )
        ],
        title: Text("Employees"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddEmployee()));
        },
        child: new Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            Form(
              key: _key,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(10.0)),
                  ListTile(
                    title: TextFormField(
                      keyboardType: TextInputType.name,
                      enableSuggestions: true,
                      validator: (input) {
                        if (input == "") {
                          return 'Field is Empty';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Search",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          icon: Icon(Icons.search)),
                      onSaved: (input) => search = input!,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                ],
              ),
            ),
            Expanded(
              child: employees.length == 0
                  ? Center(
                      child: Text("No Employees Added yet"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(padding: EdgeInsets.all(10.0)),
                                      Text(
                                        employees[index]['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Padding(padding: EdgeInsets.all(5.0)),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                var url = employees[index]
                                                        ['phone']
                                                    .toString();

                                                await FlutterPhoneDirectCaller
                                                    .callNumber(url);
                                              },
                                              icon: Icon(Icons.call)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.email)),
                                          IconButton(
                                              onPressed: () {
                                                prefs?.setString('empID',
                                                    employees[index]['_id']);

                                                print(
                                                    prefs?.getString('empID'));
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ManageEmployee()));
                                              },
                                              icon:
                                                  Icon(Icons.manage_accounts)),
                                        ],
                                      )
                                    ]
                                        .map((e) => Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 0, 0, 0),
                                              child: e,
                                            ))
                                        .toList()),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: employees.length,
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getEmplyees() async {
    http.Response response = await http.get(
        Uri.parse("http://192.168.29.211:5000/api/employee/all"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'x-api-key': token!
        });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        employees = data;
      });
    } else {
      print("Error");
    }
  }
}
