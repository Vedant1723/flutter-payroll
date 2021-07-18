import 'package:flutter/material.dart';
import 'package:payroll/components/Auth/OtpPage.dart';
import 'package:payroll/components/Auth/SignupPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  String email = "", password = "";
  SharedPreferences? prefs;

  bool showPassword = false;

  viewPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  void initState() {
    super.initState();
    initializePreference();
  }

  Future<void> initializePreference() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setString("onBoarded", "true");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(25.0)),
              Icon(
                Icons.task_rounded,
                size: 60.0,
              ),
              Padding(padding: EdgeInsets.all(10.0)),
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
                      icon: Icon(Icons.mail)),
                  onSaved: (input) => email = input!,
                ),
              ),
              ListTile(
                title: TextFormField(
                  obscureText: !showPassword,
                  validator: (input) {
                    if (input == "") {
                      return 'Field is Empty';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Password",
                      icon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: showPassword
                            ? new Icon(Icons.no_encryption_sharp)
                            : new Icon(Icons.enhanced_encryption),
                        onPressed: viewPassword,
                      )),
                  onSaved: (input) => password = input!,
                ),
              ),
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
                      sendOTP();
                    },
                    splashColor: Colors.black,
                    child: Text("Login"),
                  )),
              Padding(padding: EdgeInsets.all(10.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Don't Have an accout? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendOTP() async {
    print(email + password);
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      http.Response response = await http.post(
        Uri.parse("http://192.168.29.211:5000/api/employer/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        if (data['statusCode'] == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("OTP Sent!"),
          ));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OtpPage()));
        }
      } else {
        print("Error");
      }
    }
  }
}
