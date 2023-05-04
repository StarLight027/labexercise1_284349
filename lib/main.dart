/*
Name: Nur Mursyidah Binti Shahul Hameed
Matric Number: 284349
Group: A222 STIW2044 MOBILE PROGRAMMING (B)
Submitted to: Sir Ahmad Hanis Bin Mohd Shabli
Submission: Lab Assignment 1
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchResults = "";
  String name = "";
  String iso2 = "";
  String currency = "";
  String capital = "";
  double unemployment = 0.0;
  double imports = 0.0;
  double exports = 0.0;
  String desc = "No Data";

  String flag = "";
  String code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1f1545),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF2E9EF9),
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Search for a Country",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 12.0,
            ),

            TextField(
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 62, 50, 103),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "eg: Malaysia",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: const Color(0xFF2196F3),
              ),
              onChanged: (value) {
                setState(() {
                  _searchResults = value;
                });
              },
            ),

            const SizedBox(
              height: 13.0,
            ),

            ElevatedButton(
                onPressed: _getCountry,
                child: const Text("Load Country Information",
                    style: TextStyle(
                      fontSize: 18,
                    ))),

            const SizedBox(
              height: 8.0,
            ),

            if (flag != "") ...[
              Image.network('https://flagsapi.com/$code/flat/64.png'),
            ],

            Text(desc,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Future<void> _getCountry() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();

    String apiid = "a8YHwDHiRUk7waWzTRRGLw==n4ez726jBuW8xBuq";
    Uri url = Uri.parse(
        'https://api.api-ninjas.com/v1/country?name=$_searchResults&appid=$apiid&units=metric');

    var response = await http.get(url, headers: {
      'X-Api-Key': apiid,
    });

    if (response.statusCode == 200) {
      String jsonData =
          response.body; //get data from response and assigned to a variable
      var parsedJson = json.decode(jsonData);

      if ((parsedJson.isEmpty) || (_searchResults.isEmpty)){
        setState(() {
          desc = "No data available";
          flag = "";
        });

        Fluttertoast.showToast(
          msg: 'Fail!',
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red.withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 20.0,
        );

        progressDialog.dismiss();
      } else {
        setState(() {
          code = parsedJson[0]['iso2'];
          flag = 'https://flagsapi.com/$code/flat/64.png';
        });

        setState(() {
          name = parsedJson[0]['name'];
          iso2 = parsedJson[0]['iso2'];
          currency = parsedJson[0]['currency']['name'];
          capital = parsedJson[0]['capital'];
          unemployment = parsedJson[0]['unemployment'];
          imports = parsedJson[0]['imports'];
          exports = parsedJson[0]['exports'];

          desc =
              "Country Name : $name \nISO Code : $iso2 \nCurrency : $currency \nCapital : $capital \nUnemployment Rate : $unemployment \nImports Rate : $imports \nExports Rate : $exports";

          Fluttertoast.showToast(
            msg: 'Success!',
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 20.0,
          );

          progressDialog.dismiss();
        });
      }
    } else {
      setState(() {
        desc = "No record";

        Fluttertoast.showToast(
          msg: 'Fail!',
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red.withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 20.0,
        );
      });
    }
  }
}
