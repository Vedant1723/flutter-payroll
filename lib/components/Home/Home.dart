import 'package:flutter/material.dart';
import 'package:payroll/components/Auth/LoginPage.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  SharedPreferences? prefs;
  Timer? timer;
  String? token;
  String title = "", description = "";
  List tasks = [];
  String taskID = "";
  bool isUpdate = false;
  String businessName = "";
  String ownerName = "";
  int totalEmps = 0, regEmps = 0, absents = 0, presents = 0, transactions = 0;

  @override
  void initState() {
    super.initState();
    initializePreference();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => getTasks());
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
                        businessName,
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
                ownerName,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Total Employees: " + totalEmps.toString(),
                  style: TextStyle(fontSize: 15)),
              Text("Registered Employees: " + regEmps.toString(),
                  style: TextStyle(fontSize: 15)),
            ],
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Absents: " + absents.toString(),
                  style: TextStyle(fontSize: 15)),
              Text("Presents: " + presents.toString(),
                  style: TextStyle(fontSize: 15)),
            ],
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Transactions: " + transactions.toString(),
                  style: TextStyle(fontSize: 15)),
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
                  style: TextStyle(fontSize: 25),
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
                          return openDialog();
                        });
                  },
                  child: Text("Add Task"),
                ),
              ),
            ],
          ),
          Expanded(
            child: tasks.length == 0
                ? Center(child: Text("No Tasks Added yet"))
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      tasks[index]['title'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Padding(padding: EdgeInsets.all(10.0)),
                                    Text(
                                      tasks[index]['description'],
                                    )
                                  ]
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 0, 0),
                                            child: e,
                                          ))
                                      .toList()),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isUpdate = true;
                                        taskID = tasks[index]["_id"];
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return openDialog();
                                          });
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      deleteTask(tasks[index]["_id"]);
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: tasks.length,
                  ),
          )
        ],
      ),
    );
  }

  Widget openDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: Container(
        width: 400,
        child: Stack(
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
                        initialValue: isUpdate ? title : "",
                        keyboardType: TextInputType.text,
                        enableSuggestions: true,
                        validator: (input) {
                          if (input == "") {
                            return 'Field is Empty';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onSaved: (input) => title = input!,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: TextFormField(
                        initialValue: isUpdate ? description : "",
                        maxLines: 10,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: true,
                        validator: (input) {
                          if (input == "") {
                            return 'Field is Empty';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onSaved: (input) => description = input!,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.black12,
                      child: Text(isUpdate ? "Update" : "Add"),
                      onPressed: () {
                        isUpdate ? updateTask(taskID) : createTask();
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

  Future<void> createTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      http.Response response = await http.post(
        Uri.parse("http://192.168.29.211:5000/api/employer/task/create-task"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': token!
        },
        body: jsonEncode(
            <String, String>{'title': title, 'description': description}),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message']),
        ));
        getTasks();
      } else {
        print("Error");
      }
    }
  }

  Future<void> updateTask(String id) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      http.Response response = await http.put(
        Uri.parse(
            "http://192.168.29.211:5000/api/employer/task/update-task/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key': token!
        },
        body: jsonEncode(
            <String, String>{'title': title, 'description': description}),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message']),
        ));
        setState(() {
          isUpdate = false;
        });
        getTasks();
      } else {
        print("Error");
      }
    }
  }

  Future<void> getTasks() async {
    http.Response response = await http.get(
      Uri.parse("http://192.168.29.211:5000/api/employer/tasks/all"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': token!
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        tasks = data;
      });

      getDetails();
    } else {
      print("Error");
    }
  }

  Future<void> getDetails() async {
    http.Response response = await http.get(
      Uri.parse("http://192.168.29.211:5000/api/employer/details"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': token!
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        businessName = data['business']['businessName'];
        ownerName = data['business']['ownerName'];
        totalEmps = data['business']['noOfEmployess'];
        regEmps = data['employeesCount'];
        presents = data['presents'];
        absents = data['absents'];
        transactions = data['transactions'];
      });
    } else {
      print("Error");
    }
  }

  Future<void> deleteTask(String id) async {
    print(id);

    http.Response response = await http.delete(
      Uri.parse(
          "http://192.168.29.211:5000/api/employer/task/delete-task/" + id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': token!
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['msg']);
      getTasks();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data["message"]),
      ));
    } else {
      print("Error");
    }
  }
}
