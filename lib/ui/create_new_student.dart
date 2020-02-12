
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
  TextEditingController _branchController;
  TextEditingController _phoneNumberController;
  TextEditingController _fatherNameController;
  TextEditingController _fatherNumberController;
  TextEditingController _motherNameController;
  TextEditingController _motherNumberController;
  TextEditingController _permanentAddressController;
  TextEditingController _dueHostelFessController;
  var _image;
  var _uploadFileURL;
  bool isLoading=false;
  final _formKey = GlobalKey<FormState>();
  var unsubscribe;

  @override
  void initState() {
    super.initState();

    _nameController = new TextEditingController(text: widget.students.usn);
    _usnController = new TextEditingController(text: widget.students.name);
    _roomNumberController = new TextEditingController(text: widget.students.roomNumber);
    _floorController = new TextEditingController(text: widget.students.floor);
    _collegeNameController = new TextEditingController(text: widget.students.collegeName);
    _emailController = new TextEditingController(text: widget.students.email);
    _branchController = new TextEditingController(text: widget.students.branch);
    _phoneNumberController = new TextEditingController();
    _fatherNameController = new TextEditingController();
    _fatherNumberController = new TextEditingController();
    _motherNameController = new TextEditingController();
    _motherNumberController = new TextEditingController();
    _permanentAddressController = new TextEditingController();
    _dueHostelFessController = new TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ADD STUDENT')),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please Enter Value or Enter Not Available';
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: _usnController,
                decoration: InputDecoration(labelText: 'USN'),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please Enter Value or Not Available';
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: _nameController,
                decoration: InputDecoration(labelText: 'ENTER STUDENT NAME'),

              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please Enter Value or Enter Not Available';
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: _branchController,
                decoration: InputDecoration(labelText: 'BRANCH'),
              ),
              TextFormField(
                validator: validateEmail,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'ENTER EMAIL'),
              ),
          Padding(padding: new EdgeInsets.all(5.0)),

          _image != null
              ? Image.asset(
            _image.path,
            height: 150,
            width: 200,
          )
              : Center(
            child: Container(),
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
                .accentColor),),

          ])
          ),
              TextField(
                controller: _roomNumberController,
                enabled: false,
                decoration: InputDecoration(labelText: 'ENTER ROOM NUMBER'),
              ),
              TextField(
                controller: _collegeNameController,
                cursorColor: Colors.red,
                enabled: false,
                decoration: InputDecoration(labelText: 'Floor'),
              ),

              TextField(
                controller: _floorController,
                enabled: false,
                decoration: InputDecoration(labelText: 'College'),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please Enter Value or Enter Not Available';
                  return null;
                },
                keyboardType:TextInputType.phone ,
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'PHONE NUMBER'),

              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please Enter Value or Enter Not Available';
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: _fatherNameController,
                decoration: InputDecoration(labelText: 'FATHER NAME'),

              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please Enter Value or Enter Not Available';
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: _fatherNumberController,
                decoration: InputDecoration(labelText: 'FATHER NUMBER'),

              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please Enter Value or Enter Not Available';
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: _motherNameController,
                decoration: InputDecoration(labelText: 'MOTHER NAME'),

              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please Enter Value or Enter Not Available';
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: _motherNumberController,
                decoration: InputDecoration(labelText: 'MOTHER NUMBER'),

              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please Enter Value or Enter Not Available';
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: _permanentAddressController,
                decoration: InputDecoration(labelText: 'PERMANENT ADDRESS'),

              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please Enter Value or Enter Not Available';
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: _dueHostelFessController,
                decoration: InputDecoration(labelText: 'DUE HOSTEL FESS'),

              ),
              SizedBox(height: 20.0,),
              Column(children: <Widget>[
                isLoading==true
                    ?CircularProgressIndicator():
                Container()

              ],),
              RaisedButton(
                  child: (widget.students.id != null) ? Text('Update') : Text(
                      'Add'),
                  onPressed: (){
                      if (_formKey.currentState.validate()) {
                        isLoading=true;
                        if (_image != null) {
                          uploadFile();
                          //_showDialog();

                        }
                        else{
                          _showDialogImage();
                        }


                      }

                  }),

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

          ]),
        ),
      ),
    );
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    String usn = _usnController.text.toUpperCase();
    String college = widget.students.floor.toUpperCase();
    _showDialog();


    StorageReference storageReference = FirebaseStorage.instance.ref().child(
        'Students/$college/$usn');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    if (uploadTask.isInProgress)
      isLoading = true;
    await uploadTask.onComplete;
    _showSuccessDialog();
    print('File Upload');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadFileURL = fileURL;
        print(_uploadFileURL);
        db.createStudent(
            _usnController.text.toUpperCase(),
            _nameController.text.toUpperCase(),
            _roomNumberController.text.toUpperCase(),
            _collegeNameController.text.toUpperCase(),
            _floorController.text.toUpperCase(),
            _uploadFileURL,
            _emailController.text,_branchController.text,_phoneNumberController.text,_fatherNameController.text,_fatherNumberController.text,_motherNameController.text,_motherNumberController.text,_permanentAddressController.text,_dueHostelFessController.text);
        role.createRoleStudent(
            widget.students.floor.toUpperCase(), _emailController.text,
            _nameController.text.toUpperCase(), 'student', '');
        db.addStudentToRoom(widget.students.collegeName.toUpperCase(),
            widget.students.floor.toUpperCase(),
            widget.students.roomNumber.toUpperCase(),
            _nameController.text.toUpperCase());
        Navigator.pop(context);
        isLoading = false;
        Navigator.of(context).pop();
        if (!uploadTask.isSuccessful) {
          _showErrorDialog(uploadTask.lastSnapshot.error);
        }
        if (uploadTask.isPaused) {
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
          title: new Text("Please Wait"),
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

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
  void _showDialogImage() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Please Add Choose Image"),
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
}