import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:system_alert_window/system_alert_window.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawer createState() => _MyDrawer();
}

class _MyDrawer extends State<MyDrawer> {
  bool contacts = false;
  bool displayOverOtherApps = false;
  bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text("TestABC"),
                accountEmail: Text("test@test.com"),
              )),
          CheckboxListTile(
            title: Text("Read Contacts"),
            value: this.contacts,
            onChanged: (bool? value) async {
              var status = await _checkContactPermission();
              if (status == PermissionStatus.granted) {
                setState(() {
                  this.contacts = true;
                });
              } else {
                var status = await _getContactPermission();
                if (status == PermissionStatus.granted) {
                  setState(() {
                    this.contacts = value!;
                  });
                }
              }
            },
          ),
          SizedBox(height: 50),
          CheckboxListTile(
            title: Text("Display over other apps"),
            value: this.displayOverOtherApps,
            onChanged: (bool? value) async {
              _checkDisplayOverAppsPermission();
                setState(() {
                  this.displayOverOtherApps = true;
                });
            },
          ),
          SizedBox(height: 50),
          CheckboxListTile(
            title: Text("Dark Theme"),
            value: this.darkTheme,
            onChanged: (bool? value) async {
              setState(() {
                this.darkTheme = value!;
                EasyDynamicTheme.of(context)
                    .changeTheme(dynamic: false, dark: value);
              });
            },
          ),
        ],
      ),
    );
  }
}

//Check contacts permission
Future<PermissionStatus> _checkContactPermission() async {
  return await Permission.contacts.status;
}

//Get contacts permission
Future<PermissionStatus> _getContactPermission() async {
  final PermissionStatus permission = await Permission.contacts.status;
  if (permission != PermissionStatus.granted) {
    final Map<Permission, PermissionStatus> permissionStatus =
        await [Permission.contacts].request();
    return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
  } else {
    return permission;
  }
}


Future<void> _checkDisplayOverAppsPermission() async {
  await SystemAlertWindow.checkPermissions;
}
