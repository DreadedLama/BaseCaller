import 'dart:convert';

import 'package:base_caller/models/response.dart';
import 'package:base_caller/widgets/drawer.dart';
import 'package:base_caller/widgets/httpCall.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String mobNumber = '';
  String searchNumber = 'N';

  @override
  Widget build(BuildContext context) {
    final trueCallerToken =
        ModalRoute.of(context)!.settings.arguments as String;

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
                                  Text('Name - ${response.name}'),
                                  SizedBox(height: 50),
                                  Text(
                                      'Number - ${response.phone!.number}, ${response.phone!.info}'),
                                  SizedBox(height: 50),
                                  Text('Email - ${response.email!.email}'),
                                  SizedBox(height: 50),
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
