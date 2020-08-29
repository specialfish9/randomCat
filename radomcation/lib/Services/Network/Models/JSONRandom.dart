class JSONRandom {
  String _type;
  int _length;
  List<int> _data;
  bool _success;

  JSONRandom({String type, int length, List<int> data, bool success}) {
    this._type = type;
    this._length = length;
    this._data = data;
    this._success = success;
  }

  String get type => _type;
  set type(String type) => _type = type;
  int get length => _length;
  set length(int length) => _length = length;
  List<int> get data => _data;
  set data(List<int> data) => _data = data;
  bool get success => _success;
  set success(bool success) => _success = success;

  JSONRandom.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _length = json['length'];
    _data = json['data'].cast<int>();
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['length'] = this._length;
    data['data'] = this._data;
    data['success'] = this._success;
    return data;
  }
}
