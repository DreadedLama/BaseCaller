import 'dart:convert';

import 'package:base_caller/models/response.dart';
import 'package:base_caller/utils/MySharedPreferences.dart';
import 'package:base_caller/widgets/drawer.dart';
import 'package:base_caller/widgets/httpCall.dart';
import 'package:flutter/material.dart';

String? trueCallerToken;

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String mobNumber = '';
  String searchNumber = 'N';

  stopBackwardRoute(BuildContext context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    getTokenString();
    stopBackwardRoute(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BaseCaller'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          /** Card Widget **/
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search',
                      suffixIcon: new IconButton(
                        icon: new Icon(Icons.search),
                        onPressed: () {
                          searchNumber = 'Y';
                          setState(() {});
                        },
                      ),
                    ),
                    onChanged: (value) {
                      this.mobNumber = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    child: FutureBuilder<String>(
                      future: (searchNumber == 'Y')
                          ? MyHttpCalls.fetchDetails(mobNumber, trueCallerToken)
                          : null,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (!snapshot.hasData) {
                          // while data is loading:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          // data loaded:
                          this.searchNumber = 'N';
                          final responseJson = snapshot.data;
                          TrueCallerResponse response =
                              TrueCallerResponse.fromJson(
                                  jsonDecode(responseJson!));
                          return Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: (response.image != null)
                                        ? NetworkImage(
                                            response.image.toString())
                                        : null,
                                  ),
                                  SizedBox(height: 50),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Name - ${response.name}'),
                                      Icon(
                                          (response.isVerified == true)
                                              ? Icons.verified_user
                                              : null,
                                          color: (response.isVerified == true)
                                              ? Colors.blueAccent
                                              : null),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Text('Number - ${response.phone!.number}'),
                                  SizedBox(height: 20),
                                  Text('${response.phone!.info}'),
                                  SizedBox(height: 20),
                                  Text('Email - ${response.email!.email}'),
                                  SizedBox(height: 20),
                                  Text(
                                      'Location - ${response.address!.address}')
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

void getTokenString() {
  final callerToken = MySharedPreferences.instance.getStringValue("token");
  callerToken.then((value) => trueCallerToken = value);
}
