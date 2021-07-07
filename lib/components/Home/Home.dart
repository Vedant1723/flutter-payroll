import 'package:flutter/material.dart';
import 'package:payroll/components/Auth/LoginPage.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  String title = "", description = "";
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
        title: Text("Home"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                  child: Center(
                    child: Container(
                      child: Text(
                        'Business name here',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ),
                  ),
                  baseColor: Colors.grey,
                  highlightColor: Colors.white),
            ],
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Owner Name here",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Total Employees: 100", style: TextStyle(fontSize: 15)),
              Text("Registered Employees: 100", style: TextStyle(fontSize: 15)),
            ],
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Absents: 100", style: TextStyle(fontSize: 15)),
              Text("Presents: 100", style: TextStyle(fontSize: 15)),
            ],
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Transactions: 100", style: TextStyle(fontSize: 15)),
            ],
          ),
          Padding(padding: EdgeInsets.all(5.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "To-Do",
                  style: TextStyle(fontSize: 25, fontFamily: "Pacifico"),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: RaisedButton(
                  color: Colors.black12,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Stack(
                              children: <Widget>[
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: TextFormField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            enableSuggestions: true,
                                            validator: (input) {
                                              if (input == "") {
                                                return 'Field is Empty';
                                              }
                                            },
                                            decoration: InputDecoration(
                                              labelText: "Title",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onSaved: (input) =>
                                                description = input!,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: TextFormField(
                                            maxLines: 10,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            enableSuggestions: true,
                                            validator: (input) {
                                              if (input == "") {
                                                return 'Field is Empty';
                                              }
                                            },
                                            decoration: InputDecoration(
                                              labelText: "Description",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onSaved: (input) =>
                                                description = input!,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                          color: Colors.black12,
                                          child: Text("Add"),
                                          onPressed: () {},
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Text("Add Task"),
                ),
              ),
            ],
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
                              Text(
                                "Title",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Padding(padding: EdgeInsets.all(10.0)),
                              Text("Description")
                            ]
                                .map((e) => Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: e,
                                    ))
                                .toList()),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                          IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
