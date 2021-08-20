import 'package:base_caller/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';

class MainPage extends State<MyApp> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
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
