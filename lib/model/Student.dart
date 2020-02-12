class Students {
  String _id;
  String _usn;
  String _name;
  String _roomNumber;
  String _floor;
  String _collegeName;
  String _imageURL;
  String _email;
  String _branch;
  String _phoneNumber;
  String _fatherName;
  String _fatherNumber;
  String _motherName;
  String _motherNumber;
  String _permanentAddress;
  String _dueHostelFees;


  Students(this._id,this._usn,this._name,this._roomNumber,this._floor,this._collegeName,this._imageURL,this._email,this._branch,this._phoneNumber,this._fatherName,this._fatherNumber,this._motherName,this._motherNumber,this._permanentAddress,this._dueHostelFees);
  Students.map(dynamic obj){
    this._id = obj['id'];
    this._usn = obj['usn'];
    this._name = obj['name'];
    this._roomNumber = obj['roomNumber'];
    this._floor = obj['floor'];
    this._collegeName = obj['collegeName'];
    this._imageURL=obj['imageURL'];
    this._email = obj['email'];
    this._branch=obj['branch'];
    this._phoneNumber=obj['phoneNumber'];
    this._fatherName=obj['fatherName'];
    this._fatherNumber=obj['fatherNumber'];
    this._motherName=obj['motherName'];
    this._motherNumber=obj['motherNumber'];
    this._permanentAddress=obj['parmanentAddress'];
    this._dueHostelFees=obj['dueHostelFees'];


  }
  String get id => _id;
  String get usn => _usn;
  String get name => _name;
  String get roomNumber => _roomNumber;
  String get floor => _floor;
  String get collegeName => _collegeName;
  String get imageURL=>_imageURL;
  String get email => _email;
  String get branch=>_branch;
  String get phoneNumber=>_phoneNumber;
  String get fatherName=>_fatherName;
  String get fatherNumber=>_fatherNumber;
  String get motherName=>_motherName;
  String get motherNumber=>_motherNumber;
  String get permanentAddress=>_permanentAddress;
  String get dueHostelFees=>_dueHostelFees;

  Map<String,dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['usn'] = _usn;
    map['name'] = _name;
    map['roomNumber'] = _roomNumber;
    map['floor'] = _floor;
    map['collegeName'] = _collegeName;
    map['imageURL']=_imageURL;
    map['email']=_email;
    map['branch']=_branch;
    map['phoneNumber']=_phoneNumber;
    map['fatherName']=_fatherName;
    map['fatherNumber']=_fatherNumber;
    map['motherName']=_motherName;
    map['motherNumber']=_motherNumber;
    map['permanentAddress']=_permanentAddress;
    map['dueHostelFees']=_dueHostelFees;
    return map;
  }
  Students.fromMap(Map<String,dynamic> map){
    this._id = map['id'];
    this._usn = map['usn'];
    this._name = map['name'];
    this._roomNumber = map['roomNumber'];
    this._floor = map['floor'];
    this._collegeName = map['collegeName'];
    this._imageURL=map['imageURL'];
    this._email = map['email'];
    this._branch=map['branch'];
    this._phoneNumber=map['phoneNumber'];
    this._fatherName=map['fatherName'];
    this._fatherNumber=map['fatherNumber'];
    this._motherName=map['motherName'];
    this._motherNumber=map['motherNumber'];
    this._permanentAddress=map['permanentAddress'];
    this._dueHostelFees=map['dueHostelFees'];

  }





}