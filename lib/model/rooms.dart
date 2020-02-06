


class Rooms {
  String _id;
  String _roomNumber;
  String _collegeName;
  String _floorLevel;
  List<String> _students;
  int _maxRoomCapacity;


  Rooms(this._id, this._roomNumber, this._collegeName,this._floorLevel,this._students,this._maxRoomCapacity);

  Rooms.map(dynamic obj) {
    this._id = obj['id'];
    this._roomNumber = obj['roomNumber'];
    this._collegeName = obj['collegeName'];
    this._floorLevel = obj['floorLevel'];
    this._students= obj['student'];
    this._maxRoomCapacity = obj['maxRoomCapacity'];
  }

  String get id => _id;
  String get roomNumber => _roomNumber;
  String get collegeName => _collegeName;
  String get floorLevel => _floorLevel;
  List<String> get students => _students;
  int get maxRoomCapacity => _maxRoomCapacity;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['roomNumber'] = _roomNumber;
    map['collegeName'] = _collegeName;
    map['floorLevel'] = _floorLevel;
    map['students'] =(_students);
    map['maxRoomCapacity'] = _maxRoomCapacity;

    return map;
  }

  Rooms.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._roomNumber = map['roomNumber'];
    this._collegeName = map['collegeName'];
    this._floorLevel = map['floorLevel'];
   this._students = List<String>.from(map['students']);
   this._maxRoomCapacity= map['maxRoomCapacity'];
  }
}
