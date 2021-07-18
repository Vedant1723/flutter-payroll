import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Salary extends StatefulWidget {
  const Salary({Key? key}) : super(key: key);

  @override
  _SalaryState createState() => _SalaryState();
}

class _SalaryState extends State<Salary> {
  GlobalKey<FormState> _formKey = new GlobalKey();

  String? id;
  String? token;
  SharedPreferences? prefs;
  bool isCreated = false;
  int? amount;
  String? amt;
  String? details;
  String? salaryID;

  String? title;

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
    getSalary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salary"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isCreated
                  ? Text(
                      amount.toString(),
                      style: TextStyle(fontSize: 30),
                    )
                  : RaisedButton(
                      color: Colors.black12,
                      onPressed: () {
                        setState(() {
                          title = "Add Salary";
                        });
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return openDialog();
                            });
                      },
                      child: Text("Create Salary"),
                    ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: Colors.black12,
                    onPressed: () {
                      setState(() {
                        title = "Add Allowance";
                      });
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return openDialog();
                          });
                    },
                    child: Text("Add Allowance"),
                  ),
                  RaisedButton(
                    color: Colors.black12,
                    onPressed: () {
                      setState(() {
                        title = "Add Cut";
                      });
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return openDialog();
                          });
                    },
                    child: Text("Add Cut"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Colors.black12,
                    onPressed: () {
                      paySalary();
                    },
                    child: Text("Pay"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget openDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Container(
        width: 400,
        height: 450,
        child: Column(
          children: <Widget>[
            Text(title!),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: TextFormField(
                        keyboardType: TextInputType.number,
                        enableSuggestions: true,
                        validator: (input) {
                          if (input == "") {
                            return 'Field is Empty';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Amount",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onSaved: (input) => amt = input!,
                      ),
                    ),
                  ),
                  isCreated
                      ? Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: TextFormField(
                              maxLines: 10,
                              keyboardType: TextInputType.emailAddress,
                              enableSuggestions: true,
                              validator: (input) {
                                if (input == "") {
                                  return 'Field is Empty';
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Details",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onSaved: (input) => details = input!,
                            ),
                          ))
                      : SizedBox(
                          height: 10,
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.black12,
                      child: Text("Add"),
                      onPressed: () {
                        if (title == "Add Allowance") {
                          addAllowance();
                        }
                        if (title == "Add Cut") {
                          addCut();
                        }
                        if (title == "Add Salary") {
                          createSalary();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getSalary() async {
    http.Response response = await http.get(
      Uri.parse("http://192.168.29.211:5000/api/salary/details/" + id!),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': token!
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);

      if (data['statusCode'] == 400) {
        setState(() {
          isCreated = false;
        });
      } else {
        setState(() {
          amount = data['salary']['amount'];
          salaryID = data['salary']['_id'];
          isCreated = true;
        });
      }
      print(isCreated);
    } else {
      print("error");
    }
  }

  Future<void> addAllowance() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      http.Response response = await http.post(
        Uri.parse("http://192.168.29.211:5000/api/salary/create-allowance/" +
            salaryID!),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': token!
        },
        body: jsonEncode(<String, String>{'amount': amt!, "details": details!}),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message']),
        ));
        getSalary();
      } else {
        print("error");
      }
    }
  }

  Future<void> addCut() async {
    print(salaryID!);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      http.Response response = await http.post(
        Uri.parse(
            "http://192.168.29.211:5000/api/salary/create-cut/" + salaryID!),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': token!
        },
        body: jsonEncode(<String, String>{'amount': amt!, "details": details!}),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message']),
        ));
        getSalary();
      } else {
        print("error");
      }
    }
  }

  Future<void> paySalary() async {
    http.Response response = await http.get(
      Uri.parse("http://192.168.29.211:5000/api/salary/pay-salary/" + id!),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': token!
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data['message']),
      ));
    } else {
      print("Error");
    }
  }

  Future<void> createSalary() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      http.Response response = await http.post(
        Uri.parse("http://192.168.29.211:5000/api/salary/create-salary/" + id!),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': token!
        },
        body: jsonEncode(<String, String>{
          'amount': amt!,
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message']),
        ));
        getSalary();
      } else {
        print("Error");
      }
    }
  }
}
