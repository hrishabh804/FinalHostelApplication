


class UpdateRooms {
  String _id;
  String _roomNumber;
  String _collegeName;
  String _floorLevel;
  int _maxRoomCapacity;


  UpdateRooms(this._id, this._roomNumber, this._collegeName,this._floorLevel,this._maxRoomCapacity);

  UpdateRooms.map(dynamic obj) {
    this._id = obj['id'];
    this._roomNumber = obj['roomNumber'];
    this._collegeName = obj['collegeName'];
    this._floorLevel = obj['floorLevel'];
    this._maxRoomCapacity = obj['maxRoomCapacity'];
  }

  String get id => _id;
  String get roomNumber => _roomNumber;
  String get collegeName => _collegeName;
  String get floorLevel => _floorLevel;
  int get maxRoomCapacity => _maxRoomCapacity;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['roomNumber'] = _roomNumber;
    map['collegeName'] = _collegeName;
    map['floorLevel'] = _floorLevel;
    map['maxRoomCapacity'] = _maxRoomCapacity;

    return map;
  }

  UpdateRooms.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._roomNumber = map['roomNumber'];
    this._collegeName = map['collegeName'];
    this._floorLevel = map['floorLevel'];
    this._maxRoomCapacity= map['maxRoomCapacity'];
  }
}
