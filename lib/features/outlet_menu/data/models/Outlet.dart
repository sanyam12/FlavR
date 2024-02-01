class Outlet{
  String _id;
  String _outletName;
  String _address;
  String _owner;
  String? _imageUrl;
  bool isFavourite = false;

  Outlet(this._id, this._address, this._outletName, this._owner, this._imageUrl);

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

  set imageUrl(String? imageUrl){
    _imageUrl = imageUrl;
  }

  String get id => _id;
  String get address=> _address;
  String get outletName => _outletName;
  String get owner => _owner;
  String? get imageUrl =>_imageUrl;

  Outlet.fromJson(Map<String, dynamic> json)
      : _id = json["_id"],
        _owner = json["owner"],
        _outletName = json["outletName"],
        _address = json["address"]["addressLine1"],
        _imageUrl = json["outletImage"]["url"];

  Map<String, dynamic> toJson() =>{
    "id":_id,
    "owner":_owner,
    "outletName":_outletName,
    "address": _address
  };

}