import 'package:base_caller/widgets/drawer.dart';
import 'package:base_caller/widgets/httpCall.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  bool value = false;
  String mobNumber = '';

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
                      var status = await _checkPermission();
                      if (status == PermissionStatus.granted) {
                        setState(() {
                          this.value = true;
                        });
                      } else {
                        var status = await _getPermission();
                        if (status == PermissionStatus.granted) {
                          setState(() {
                            this.value = value!;
                          });
                        }
                      }
                    },
                  ),
                  SingleChildScrollView(
                    child: FutureBuilder<String>(
                      future: (mobNumber.length == 10)
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
                          final response = snapshot.data;
                          return Center(
                            child: Text(response!),
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
