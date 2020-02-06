class Students {
  String _id;
  String _usn;
  String _name;
  String _roomNumber;
  String _floor;
  String _collegeName;
  String _imageURL;
  String _email;
  Students(this._id,this._usn,this._name,this._roomNumber,this._floor,this._collegeName,this._imageURL,this._email);
  Students.map(dynamic obj){
    this._id = obj['id'];
    this._usn = obj['usn'];
    this._name = obj['name'];
    this._roomNumber = obj['roomNumber'];
    this._floor = obj['floor'];
    this._collegeName = obj['collegeName'];
    this._imageURL=obj['imageURL'];
    this._email = obj['email'];


  }
  String get id => _id;
  String get usn => _usn;
  String get name => _name;
  String get roomNumber => _roomNumber;
  String get floor => _floor;
  String get collegeName => _collegeName;
  String get imageURL=>_imageURL;
  String get email => _email;

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

  }





}