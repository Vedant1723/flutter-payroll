import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:payroll/components/Salary/Salary.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ManageEmployee extends StatefulWidget {
  const ManageEmployee({Key? key}) : super(key: key);

  @override
  _ManageEmployeeState createState() => _ManageEmployeeState();
}

class _ManageEmployeeState extends State<ManageEmployee> {
  String? id;
  String? token;
  String markAs = "";
  SharedPreferences? prefs;
  String name = "", email = "", phone = "", address = "";

  @override
  void initState() {
    super.initState();
    initializePreference();
  }

  Future<void> initializePreference() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs?.getString("token");
      id = prefs?.getString('empID');
    });
    getEmployeeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    email,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    phone,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    address,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Attendance:",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: Colors.black12,
                    onPressed: () {
                      setState(() {
                        markAs = "present";
                      });
                      markAttendance();
                    },
                    child: Text("Present"),
                  ),
                  RaisedButton(
                    color: Colors.black12,
                    onPressed: () {
                      setState(() {
                        markAs = "absent";
                      });
                      markAttendance();
                    },
                    child: Text("Absent"),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Salary:",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Colors.black12,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Salary()));
                    },
                    child: Text("Generate"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getEmployeeDetails() async {
    http.Response response = await http.get(
      Uri.parse("http://192.168.29.211:5000/api/employee/" + id!),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': token!
      },
    );
    if (response.statusCode == 200) {
      // Set the data
      var data = jsonDecode(response.body);

      setState(() {
        name = data['name'];
        address = data['address'];
        phone = data['phone'].toString();
        email = data['email'];
      });
    } else {
      print("Error");
    }
  }

  Future<void> markAttendance() async {
    print("hey");
    http.Response response = await http.post(
      Uri.parse("http://192.168.29.211:5000/api/employer/attendance/mark/" +
          id! +
          "/" +
          markAs),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': token!
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data['message']),
      ));
    } else {
      print('Error');
    }
  }
}
