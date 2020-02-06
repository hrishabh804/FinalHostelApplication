class UserRoles {
  String _name;
  String _college;
  String _email;
  String _role;
  String _uid;

  UserRoles(this._name, this._email, this._college, this._role,this._uid);

  UserRoles.map(dynamic obj) {
    this._college = obj['college'];
    this._email = obj['email'];
    this._name = obj['name'];
    this._role = obj['role'];
    this._uid = obj['uid'];
  }

  String get name => _name;
  String get college => _college;
  String get email => _email;
  String get role => _role;
  String get uid => _uid;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['college'] = _college;
    map['email'] = _email;
    map['name'] = _name;
    map['role'] = _role;
    map['uid']=_uid;

    return map;
  }

  UserRoles.fromMap(Map<String, dynamic> map) {
    this._college = map['college'];
    this._email = map['email'];
    this._name = map['name'];
    this._role = map['role'];
    this._uid = map['uid'];
  }
}
