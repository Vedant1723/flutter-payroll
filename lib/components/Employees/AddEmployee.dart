import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  GlobalKey<FormState> _key = new GlobalKey();
  SharedPreferences? prefs;

  List<String> locations = ['Per Hour', 'Monthly', 'Weekly', 'Per Unit'];
  String? token;

  String email = "",
      password = "",
      businessName = "",
      name = "",
      businessType = "",
      address = "",
      salaryType = "",
      phone = "",
      salary = "";

  @override
  void initState() {
    super.initState();
    initializePreference();
  }

  Future<void> initializePreference() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs?.getString("token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add Employee"),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(25.0)),
                  Icon(
                    Icons.people,
                    size: 60.0,
                  ),
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
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          icon: Icon(Icons.person)),
                      onSaved: (input) => name = input!,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: true,
                      validator: (input) {
                        if (input == "") {
                          return 'Field is Empty';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          icon: Icon(Icons.email)),
                      onSaved: (input) => email = input!,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (input) {
                        if (input == "") {
                          return 'Field is Empty';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Phone",
                        icon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (input) => phone = input!,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      validator: (input) {
                        if (input == "") {
                          return 'Field is Empty';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Address",
                        icon: Icon(Icons.location_city),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (input) => address = input!,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      keyboardType: TextInputType.number,
                      enableSuggestions: true,
                      validator: (input) {
                        if (input == "") {
                          return 'Field is Empty';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Salary",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          icon: Icon(Icons.payment)),
                      onSaved: (input) => salary = input!,
                    ),
                  ),
                  DropdownButton<String>(
                      items: locations.map((String val) {
                        return new DropdownMenuItem<String>(
                          value: val,
                          child: new Text(val),
                        );
                      }).toList(),
                      hint: Text("Please choose a Salary Type"),
                      onChanged: (newVal) {
                        // _selectedLocation = newVal;
                        this.setState(() {
                          if (newVal == "Per Hour") {
                            salaryType = "perHour";
                          }
                          if (newVal == 'Monthly') {
                            salaryType = "monthly";
                          }
                          print(salaryType);
                        });
                      }),
                  Padding(padding: EdgeInsets.all(10.0)),
                  ButtonTheme(
                      minWidth: 200.0,
                      height: 45.0,
                      child: RaisedButton(
                        color: Colors.black12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue)),
                        onPressed: () {
                          createEmployee();
                        },
                        splashColor: Colors.black,
                        child: Text("Add Emplloyee"),
                      )),
                  Padding(padding: EdgeInsets.all(10.0)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createEmployee() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      http.Response response = await http.post(
        Uri.parse("http://192.168.29.211:5000/api/employee/create-employee"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': token!
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'address': address,
          'phone': phone,
          'salary': salary,
          'salaryType': salaryType
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message']),
        ));
      } else {
        print("Error");
      }
    }
  }
}
