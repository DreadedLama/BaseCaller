import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:root_access/root_access.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool value = false;
  // bool _rootStatus = false;

  // @override
  // void initState() {
  //   super.initState();
  //   initRootRequest();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
          backgroundColor: Colors.greenAccent[400],
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {},
          ),
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
                      hintText: 'Enter a search term',
                    ),
                  ),
                  SizedBox(height: 10),
                  CheckboxListTile(
                    title: Text("Read Contacts"),
                    value: this.value,
                    onChanged: (bool? value) async {
                      var status = await _checkPermission();
                      if (status == PermissionStatus.granted) {
                        setState(() {
                          this.value = true;
                        });
                      } else {
                        var status = await _getPermission();
                        if (status == PermissionStatus.granted) {
                          setState(() {
                            this.value = true;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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

//Get root permission
Future<int> initRootRequest() async {
  bool rootAccess = await RootAccess.requestRootAccess;
  print('rootstatus - '+rootAccess.toString());
  return readCounter();
}

Future<File> get _authFile async {
  print('return truecaller');
  // return File('/data/data/com.truecaller/files/account.v2.bak');
  return File('/storage/emulated/0/data/Truecaller.json');
}

Future<int> readCounter() async {
  try {
    print('reading file');
    final file = await _authFile;
    print('Got the file');
    final contents = await file.readAsString(); // Read the file
    print('contents = '+contents);
    return int.parse(contents);
  } catch (e) {
    print(e);
    return 0; // If encountering an error, return 0
  }
}