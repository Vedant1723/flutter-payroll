import 'package:flutter/material.dart';
import 'package:payroll/components/Auth/LoginPage.dart';
import 'package:payroll/components/Employees/AddEmployee.dart';

class Employees extends StatefulWidget {
  const Employees({Key? key}) : super(key: key);

  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  String search = "";
  GlobalKey<FormState> _key = new GlobalKey();

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
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.0),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(padding: EdgeInsets.all(10.0)),
                                Text(
                                  "Employee name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(padding: EdgeInsets.all(5.0)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.call)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.email)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.manage_accounts)),
                                  ],
                                )
                              ]
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 0, 0),
                                        child: e,
                                      ))
                                  .toList()),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
