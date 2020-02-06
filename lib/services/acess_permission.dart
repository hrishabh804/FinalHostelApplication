import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AskForPermission extends StatefulWidget {
  @override
  _AskForPermissionState createState() => _AskForPermissionState();
}

class _AskForPermissionState extends State<AskForPermission> {
  Map<PermissionGroup, PermissionStatus> permissions;

  @override
  void initState() {
    super.initState();
    getPermission();
  }
  void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([
      PermissionGroup.location,
      PermissionGroup.camera,
      PermissionGroup.locationAlways,
      PermissionGroup.phone,
      PermissionGroup.sensors,
      PermissionGroup.storage,
      PermissionGroup.microphone,
    ]);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask for permisions'),
        backgroundColor: Colors.red,
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Text("All Permission Granted"),
            ],
          )
      ),

    );
  }
}
