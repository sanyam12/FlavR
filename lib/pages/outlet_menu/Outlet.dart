class Outlet{
  String _id;
  String _outletName;
  String _address;
  String _owner;

  Outlet(this._id, this._address, this._outletName, this._owner);

  //setter
  set id(String id){
    _id = id;
  }

  set outletName(String name){
    _outletName = name;
  }

  set address(String address){
    _address = address;
  }

  set owner(String owner){
    _owner = owner;
  }

  String get id => _id;
  String get address=> _address;
  String get outletName => _outletName;
  String get owner => _owner;

  Outlet.fromJson(Map<String, dynamic> json)
      : _id = json["_id"],
        _owner = json["owner"],
        _outletName = json["outletName"],
        _address = json["address"];

  Map<String, dynamic> toJson() =>{
    "id":_id,
    "owner":_owner,
    "outletName":_outletName,
    "address": _address
  };
}