import 'dart:convert';

import 'package:base_caller/widgets/drawer.dart';
import 'package:base_caller/widgets/httpCall.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
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
                          print('set true');
                          searchNumber = 'Y';
                          setState(() {
                          });
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
                      future: (searchNumber=='Y')
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
                          return Center(
                            child: Text(responseJson!),
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
