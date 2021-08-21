import 'dart:io';

import 'package:base_caller/widgets/drawer.dart';
import 'package:base_caller/widgets/httpCall.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  bool value = false;
  String httpCallResponse = '';
  String mobNumber = '';

  @override
  Widget build(BuildContext context) {

    // if(mobNumber.length==10) {
    //   MyHttpCalls.fetchDetails(mobNumber,
    //       token)
    //       .then((response) => this.httpCallResponse = response);
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('My First App'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
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
                  ),
                  onChanged: (value) {
                    this.mobNumber = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: 10),
                CheckboxListTile(
                  title: Text("Read Contacts"),
                  value: this.value,
                  onChanged: (bool? value) async {
                    print('Hi');
                    var status = await _checkPermission();
                    if (status == PermissionStatus.granted) {
                      print('if');
                      setState(() {
                        this.value = true;
                      });
                    } else {
                      print('else');
                      var status = await _getPermission();

                      if (status == PermissionStatus.granted) {
                        print('in if');
                        setState(() {
                          this.value = value!;
                        });
                      }
                    }
                  },
                ),
                FutureBuilder<String>(
                  future: (mobNumber.length == 10)?
                  MyHttpCalls.fetchDetails(mobNumber,"token"):null,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (!snapshot.hasData) {
                      // while data is loading:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      // data loaded:
                      final response = snapshot.data;
                      return Center(
                        child: Text(response!),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

//Check contacts permission
Future<PermissionStatus> _checkPermission() async {
  return await Permission.contacts.status;
}

//Get contacts permission
Future<PermissionStatus> _getPermission() async {
  final PermissionStatus permission = await Permission.contacts.status;
  if (permission != PermissionStatus.granted) {
    final Map<Permission, PermissionStatus> permissionStatus =
        await [Permission.contacts].request();
    return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
  } else {
    return permission;
  }
}
