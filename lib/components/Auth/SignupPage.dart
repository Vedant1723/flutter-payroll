import 'package:flutter/material.dart';
import 'package:payroll/components/Auth/LoginPage.dart';
import 'package:payroll/components/Auth/OtpPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  String email = "",
      password = "",
      businessName = "",
      ownerName = "",
      businessType = "",
      noOfEmployees = "";
  int? phone;

  bool showPassword = false;

  viewPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
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
                    keyboardType: TextInputType.name,
                    enableSuggestions: true,
                    validator: (input) {
                      if (input == "") {
                        return 'Field is Empty';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Business Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        icon: Icon(Icons.business)),
                    onSaved: (input) => businessName = input!,
                  ),
                ),
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
                        labelText: "Owner Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        icon: Icon(Icons.person)),
                    onSaved: (input) => ownerName = input!,
                  ),
                ),
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
                        labelText: "Business Type",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        icon: Icon(Icons.merge_type)),
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
                      labelText: "Number of Employees",
                      icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (input) => noOfEmployees = input!,
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
                        icon: Icon(Icons.mail)),
                    onSaved: (input) => email = input!,
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
                        labelText: "Phone",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        icon: Icon(Icons.phone)),
                    onSaved: (input) => phone = input! as int?,
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
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        icon: Icon(Icons.lock),
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("OTP Sent!"),
                        ));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => OtpPage()));
                      },
                      splashColor: Colors.black,
                      child: Text("Signup"),
                    )),
                Padding(padding: EdgeInsets.all(10.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Already Have an accout? "),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Login",
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
      ),
    );
  }
}
