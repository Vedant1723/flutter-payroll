import 'package:flutter/material.dart';
import 'package:payroll/components/Home/Home.dart';
import 'package:payroll/components/Home/HomePage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  String otp = "";
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    initializePreference();
  }

  Future<void> initializePreference() async {
    prefs = await SharedPreferences.getInstance();
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
                Icons.payment,
                size: 60.0,
              ),
              Padding(padding: EdgeInsets.all(10.0)),
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
                      labelText: "OTP",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      icon: Icon(Icons.confirmation_number)),
                  onSaved: (input) => otp = input!,
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
                      verifyOTP();
                    },
                    splashColor: Colors.black,
                    child: Text("Verify OTP"),
                  )),
              Padding(padding: EdgeInsets.all(10.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("OTP not Recieved? "),
                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SignUpPage()));
                    },
                    child: Text(
                      "Send Again?",
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

  Future<void> verifyOTP() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      http.Response response = await http.post(
        Uri.parse("http://192.168.29.210:5000/api/employer/confirm-otp"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'otp': otp}),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        if (data['statusCode'] == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("OTP Verified!"),
          ));
          prefs?.setString("token", data['token']);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        }
      }
    } else {
      print("Error");
    }
  }
}
