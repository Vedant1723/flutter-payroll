import 'package:flutter/material.dart';
import 'package:payroll/components/Auth/LoginPage.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
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
                  child: DataTable(columns: [
                    DataColumn(
                        label: Text('#',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Name',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Amount',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Reason',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Date',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                  ], rows: [
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Stephen')),
                      DataCell(Text('10,000')),
                      DataCell(Text('Salary')),
                      DataCell(Text('23/09/1998')),
                    ]),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
