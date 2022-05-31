import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

//const _spreadsheetID = '1Bpuodsd9QEQRAw58r0Fovl1NPRUFEClKyJLHWjCIvs4';
const _spreadsheetID = '1wk2Fa3TJ4S-Xlra629Mr-csBHX4J3ik1j9BPS43VLGo';
void main() async {
  //print("Date amd Time are  : " + DateTime.now().toString());
  // init GSheets
  //final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  //final ss = await gsheets.spreadsheet(_spreadsheetID);
  // get worksheet by its title
  //var sheet = ss.worksheetByTitle('Sheet1');
  // create worksheet if it does not exist yet
  //sheet ??= await ss.addWorksheet('example');

  // update cell at 'B2' by inserting string 'new'
  // await sheet.values.insertValue('A', column: 3, row: 2);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  screen createState() {
    return screen();
  }
}

class screen extends State<MyApp> {
  // This widget is the root of your application.
  String paidby = "Sibasish";
  String paidfor = "Sibasish";
  String category = "Cab";
  double amount = 0.0;
  String description = "";
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'St',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Trip Expenditure"),
          ),
          body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.lightGreenAccent,
                      Colors.tealAccent,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: isProcessing ? progressBar() : UI()),
        ));
  }

  Widget progressBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: 40),
            child: CircularProgressIndicator()),
        Center(
            child: Text(
          "Adding Record Please Wait...",
          style: TextStyle(fontSize: 16),
        ))
      ],
    );
  }

  Widget UI() {
    //print(category);
    return Container(
      child: Column(
        children: [
          //Text('hello'),
          paidBy(),
          paidFor(),
          categorySelect(),
          amountField(),
          descriptionField(),
          addButton(),
          openSheetButton(),
        ],
      ),
    );
  }

  Widget paidBy() {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Container(margin: EdgeInsets.all(20), child: Text("Paid By ")),
          dropDownName(),
          //Container(width: 300, child: TextField()),
        ],
      ),
    );
  }

  Widget dropDownName() {
    return Container(
        width: 250,
        child: DropdownButton<String>(
          //hint: Text("hintt"),
          value: paidby,
          isExpanded: true,
          //icon: const Icon(Icons.arrow_downward),
          //iconSize: 24,
          //elevation: 16,
          //style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 1,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              paidby = newValue!;
            });
          },
          items: <String>['Raja', 'Lala', 'Bubun', 'Sibasish']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList(),
        ));
  }

  Widget paidFor() {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Container(margin: EdgeInsets.all(20), child: Text("Paid for")),
          dropDownFor(),
          //Container(width: 300, child: TextField()),
        ],
      ),
    );
  }

  Widget dropDownFor() {
    return Container(
        width: 250,
        child: DropdownButton<String>(
          isExpanded: true,
          //hint: Text("Paid for"),
          value: paidfor,
          underline: Container(
            height: 1,
            color: Colors.deepPurpleAccent,
          ),
          //icon: const Icon(Icons.arrow_downward),
          //iconSize: 24,
          //elevation: 16,
          // style: const TextStyle(color: Colors.deepPurple),
          /*underline: Container(
            height: 1,
            color: Colors.deepPurpleAccent,
          ),*/
          onChanged: (String? newValue) {
            setState(() {
              paidfor = newValue!;
            });
          },
          items: <String>[
            'All',
            'Raja',
            'Bubun',
            'Lala',
            'Sibasish',
            'Raja and Bubun',
            'Raja and Lala',
            'Raja and Sibasish',
            'Bubun and Lala',
            'Bubun and Sibasish',
            'Lala and Sibasish',
            'Bubun, Lala and Sibasish',
            'Raja, Bubun and Sibasish',
            'Raja, Lala and Sibasish',
            'Raja, Lala and Bubun'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                //style: TextStyle(color: Colors.blue),
              ),
            );
          }).toList(),
        ));
  }

  Widget amountField() {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          //Container(margin: EdgeInsets.all(20), child: Text("AMTT")),
          Container(
              margin: EdgeInsets.only(left: 80),
              height: 50,
              width: 200,
              child: TextField(
                decoration: new InputDecoration(
                    border: OutlineInputBorder(), labelText: "Amount ₹"),
                keyboardType: TextInputType.number,
                onChanged: (nvalue) {
                  setState(() {
                    amount = double.parse(nvalue);
                  });
                },
              )),
        ],
      ),
    );
  }

  Widget descriptionField() {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          //Container(margin: EdgeInsets.all(20), child: Text("Description")),
          Container(
              margin: EdgeInsets.only(left: 80, top: 20),
              height: 50,
              width: 200,
              child: TextField(
                decoration: new InputDecoration(
                    border: OutlineInputBorder(), labelText: "Description"),
                onChanged: (nvalue) {
                  setState(() {
                    description = nvalue;
                  });
                },
              )),
        ],
      ),
    );
  }

  Widget categorySelect() {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Container(margin: EdgeInsets.all(20), child: Text("Category")),
          dropDownCategory(),
          //Container(width: 300, child: TextField()),
        ],
      ),
    );
  }

  Widget dropDownCategory() {
    return Container(
        width: 250,
        child: DropdownButton<String>(
          value: category,
          isExpanded: true,
          //icon: const Icon(Icons.arrow_downward),
          //iconSize: 24,
          //elevation: 16,
          //style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 1,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              category = newValue!;
            });
          },
          items: <String>[
            'Bus',
            'Train',
            'Cab',
            'Tea',
            'Coffee',
            'Breakfast',
            'Lunch',
            'Dinner',
            'Snacks',
            'Ticket',
            'Hotel'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList(),
        ));
  }

  Widget addButton() {
    //addRecord();

    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        width: 300,
        height: 50,
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                        side: BorderSide(color: Colors.amber)))),
            onPressed: () {
              addRecord();

              /*print("pp " + paidby);
              print("pf " + paidfor);
              print("Ct select " + category);
              print("Amount " + amount.toString());
              print("Description " + description);*/
            },
            child: Text("ADD")));
  }

  Widget openSheetButton() {
    //addRecord();
    return Container(
        margin: EdgeInsets.all(0),
        width: 300,
        height: 50,
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                        side: BorderSide(color: Colors.amber)))),
            onPressed: () {
              launchInBrowser(
                  'https://docs.google.com/spreadsheets/d/1wk2Fa3TJ4S-Xlra629Mr-csBHX4J3ik1j9BPS43VLGo/edit#gid=0');
            },
            child: Text("OPEN SHEET")));
  }

  void addRecord() async {
    setState(() {
      isProcessing = true;
    });

    final gsheets = GSheets(_credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(_spreadsheetID);
    // get worksheet by its title
    var sheet = ss.worksheetByTitle('Backend');
    // create worksheet if it does not exist yet
    sheet ??= await ss.addWorksheet('Backend');

    // update cell at 'B2' by inserting string 'new'
    //await sheet.values.insertValue('new', column: 2, row: 2);
    // prints 'new'
    var x = await sheet.values.value(column: 9, row: 1);
    int z = int.parse(x);
    await sheet.values.insertValue(z + 1, column: 9, row: 1);
    print("Last record" + int.parse(x).toString());
    int recordNo = z + 1;
    int slNo = z - 1;
    // get worksheet by its title
    sheet = ss.worksheetByTitle('Sheet1');
    // create worksheet if it does not exist yet
    sheet ??= await ss.addWorksheet('Sheet1');
    var rowData = [slNo, paidby, amount, paidfor];
    await sheet.values.insertRow(recordNo, rowData);
    await sheet.values
        .insertValue(DateTime.now().toString(), column: 14, row: recordNo);
    await sheet.values.insertValue('Not set', column: 6, row: recordNo);
    await sheet.values.insertValue('Not set', column: 8, row: recordNo);
    await sheet.values.insertValue('Not set', column: 10, row: recordNo);
    await sheet.values.insertValue('Not set', column: 12, row: recordNo);
    await sheet.values.insertValue(category, column: 15, row: recordNo);
    await sheet.values.insertValue(description, column: 16, row: recordNo);
    await sheet.values
        .insertValue('Normal', column: 17, row: recordNo)
        .whenComplete(() {
      show("Added Record Successfully");
      setState(() {
        isProcessing = false;
      });
    });
  }

  void show(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
