import 'package:flutter/material.dart';
import 'package:payroll/components/Employees/Employees.dart';
import 'package:payroll/components/Home/Home.dart';
import 'package:payroll/components/Profile/Profile.dart';
import 'package:payroll/components/Transactions/Transactions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Employees(),
    Transactions(),
    Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.people),
            title: new Text('Employees'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            title: Text('Transaction'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          )
        ],
      ),
    );
  }
}
