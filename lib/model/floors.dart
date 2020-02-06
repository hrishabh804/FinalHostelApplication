
class Floors {
  String _id;
  String _floorLevel;
  String _collegeName;

  Floors(this._id, this._floorLevel, this._collegeName);

  Floors.map(dynamic obj) {
    this._id = obj['id'];
    this._floorLevel = obj['floorLevel'];
    this._collegeName = obj['collegeName'];
  }

  String get id => _id;
  String get title => _floorLevel;
  String get description => _collegeName;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['floorLevel'] = _floorLevel;
    map['collegeName'] = _collegeName;

    return map;
  }

  Floors.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._floorLevel = map['floorLevel'];
    this._collegeName = map['collegeName'];
  }
}
