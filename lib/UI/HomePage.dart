import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  double minPadding = 16.0;
  var genderResult = "", probResult;

  genderPredictor(String name) async {
    var url = "https://api.genderize.io/?name=$name";
    var responce = await http.get(url);
    var body = jsonDecode(responce.body);
    genderResult = body['gender'];
    probResult = body['probability'];
    debugPrint(responce.body);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Text(
                "Gender Predictor",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.045,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
            ),
            Image(
              height: MediaQuery.of(context).size.height * 0.24,
              image: AssetImage("images/pic1.png"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Enter Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    )),
              ),
            ),
            genderResult != ""
                ? Text(
                    "  Gender: $genderResult\n\nProbability: ${probResult * 100} %",
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  )
                : Text(""),
            MaterialButton(
              color: Colors.pink[600],
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.red)),
              onPressed: () {
                print("method hit");
                genderPredictor(nameController.text);
              },
              child: genderResult == ""
                  ? Text(
                      "PREDICT",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4,
                        fontSize: 32.0,
                      ),
                    )
                  : Text(
                      "Try again",
                      style: TextStyle( 
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4,
                        fontSize: 32.0,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
