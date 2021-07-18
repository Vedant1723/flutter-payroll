import 'package:flutter/material.dart';
import 'package:payroll/components/Auth/LoginPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List salaries = [];
  SharedPreferences? prefs;
  Timer? timer;
  String? token;

  @override
  void initState() {
    super.initState();
    initializePreference();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => getSalaries());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
        title: Text("Transactions"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(10.0)),
            Text(
              'Transactions',
              style: TextStyle(fontSize: 25),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                          label: Text('Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Amount',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Status',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Date',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                    rows:
                        salaries // Loops through dataColumnText, each iteration assigning the value to element
                            .map(
                              ((element) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(element[
                                          "_id"])), //Extracting from Map element the value
                                      DataCell(
                                          Text(element["amount"].toString())),
                                      DataCell(Text(element["status"])),
                                      DataCell(
                                          Text(element["date"].toString())),
                                    ],
                                  )),
                            )
                            .toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getSalaries() async {
    http.Response response = await http.get(
      Uri.parse("http://192.168.29.211:5000/api/salary/all"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': token!
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      setState(() {
        salaries = data;
      });
    }
  }
}
