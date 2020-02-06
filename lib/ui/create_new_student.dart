
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hostel_project/model/Student.dart';
import 'package:hostel_project/services/student_firestore_firebase.dart';
import 'package:hostel_project/services/user_roles_firestore.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class CreateStudentPage extends StatefulWidget {
  final Students students;
  CreateStudentPage(this.students,{this.uid});
  String uid;

  @override
  State<StatefulWidget> createState() => new _CreateStudentPageState();
}

class _CreateStudentPageState extends State<CreateStudentPage> {
  StudentFirestoreService db = new StudentFirestoreService();
  RoleFirestoreService role = new RoleFirestoreService();
  TextEditingController _nameController;
  TextEditingController _usnController;
  TextEditingController _roomNumberController;
  TextEditingController _floorController;
  TextEditingController _collegeNameController;
  TextEditingController _emailController;
  var _image;
  var _uploadFileURL;
  bool isLoading;

  var unsubscribe;

  @override
  void initState() {
    super.initState();

    _nameController = new TextEditingController(text: widget.students.usn);
    _usnController = new TextEditingController(text: widget.students.name);
    _roomNumberController = new TextEditingController(text: widget.students.roomNumber);
    _floorController = new TextEditingController(text: widget.students.floor);
    _collegeNameController = new TextEditingController(text: widget.students.collegeName);
    _emailController = new TextEditingController(text:widget.students.email);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ADD STUDENT')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _usnController,
              decoration: InputDecoration(labelText: 'USN'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'ENTER STUDENT NAME'),
            ),
            TextField(
              controller: _roomNumberController,
              enabled: false,
              decoration: InputDecoration(labelText: 'ENTER ROOM NUMBER'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'ENTER EMAIL'),
            ),
            TextField(
              controller: _floorController,
              enabled: false,
              decoration: InputDecoration(labelText: 'FLOOR'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _collegeNameController,
              cursorColor: Colors.red,
              enabled: false,
              decoration: InputDecoration(labelText: 'COLLEGE'),
            ),
            Center(child: Row(children: <Widget>[
              IconButton(
                iconSize: 40.0,
                icon: Icon(Icons.camera_alt, color: Theme
                    .of(context)
                    .accentColor,),
                onPressed: () {
                  chooseFile();
                },
              ),
              SizedBox(height: 5.0,),
              Text('ADD IMAGE', style: TextStyle(color: Theme
                  .of(context)
                  .accentColor),)

            ])),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.students.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (_image != null) {
                  print(_image);
                  uploadFile();

                }
                /*
                if (widget.students.id != null) {
                  db
                      .updateStudent(
                      Students(widget.students.id,_usnController.text.toUpperCase(),_nameController.text.toUpperCase(),_roomNumberController.text.toUpperCase(),_floorController.text.toUpperCase(),_collegeNameController.text.toUpperCase(),))
                      .then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  db.createStudent(_usnController.text.toUpperCase(),_nameController.text.toUpperCase(),_roomNumberController.text.toUpperCase(),_floorController.text.toUpperCase(),_collegeNameController.text.toUpperCase()).then((_) {
                    Navigator.pop(context);
                  });
                }


                 */
              },
            ),
          ],
        ),
      ),
    );
  }
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((image){
      setState(() {
        _image =image;
      });
    });

  }

  Future uploadFile() async {
    String usn= _usnController.text;
    String college = widget.students.floor;
    _showDialog();


    StorageReference storageReference =FirebaseStorage.instance.ref().child('Students/$college/$usn');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    if(uploadTask.isInProgress)
      isLoading = true;
    await uploadTask.onComplete;
    _showSuccessDialog();
    print('File Upload');
    storageReference.getDownloadURL().then((fileURL){
      setState(() {
        _uploadFileURL =fileURL;
        print(_uploadFileURL);
        db.createStudent(_usnController.text.toUpperCase(),_nameController.text.toUpperCase(),_roomNumberController.text.toUpperCase(),_collegeNameController.text,_floorController.text.toUpperCase(),_uploadFileURL,_emailController.text);
        role.createRoleStudent(widget.students.collegeName, _emailController.text, _nameController.text,'student','');
          db.addStudentToRoom(widget.students.collegeName,widget.students.floor,widget.students.roomNumber,_nameController.text);
          Navigator.pop(context);
          isLoading = false;
        Navigator.of(context).pop();
        if(!uploadTask.isSuccessful)
        {
          _showErrorDialog(uploadTask.lastSnapshot.error);
        }
        if(uploadTask.isPaused)
        {
          _showErrorDialog(uploadTask.lastSnapshot.error);
        }

      });
    });


  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showSuccessDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Data Uploaded Sucessfully"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showErrorDialog(var error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text(error),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );


  }
}