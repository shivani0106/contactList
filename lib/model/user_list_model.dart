class UserListMaster {
  int? _page;
  int? _perPage;
  int? _total;
  int? _totalPages;
  List<Data>? _data;
  Support? _support;

  UserList(
      {int? page,
      int? perPage,
      int? total,
      int? totalPages,
      List<Data>? data,
      Support? support}) {
    this._page = page;
    this._perPage = perPage;
    this._total = total;
    this._totalPages = totalPages;
    this._data = data!;
    this._support = support;
  }

  int? get page => _page;
  set page(int? page) => _page = page;
  int? get perPage => _perPage;
  set perPage(int? perPage) => _perPage = perPage;
  int? get total => _total;
  set total(int? total) => _total = total;
  int? get totalPages => _totalPages;
  set totalPages(int? totalPages) => _totalPages = totalPages;
  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;
  Support? get support => _support;
  set support(Support? support) => _support = support;

  UserListMaster.fromJson(dynamic json) {
    _page = json['page'];
    _perPage = json['per_page'];
    _total = json['total'];
    _totalPages = json['total_pages'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data!.add(new Data.fromJson(v));
      });
    }
    _support =
        json['support'] != null ? new Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this._page;
    data['per_page'] = this._perPage;
    data['total'] = this._total;
    data['total_pages'] = this._totalPages;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    if (this._support != null) {
      data['support'] = this._support!.toJson();
    }
    return data;
  }
}

class Data {
  int? _id;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _avatar;

  Data(
      {int? id,
      String? email,
      String? firstName,
      String? lastName,
      String? avatar}) {
    this._id = id;
    this._email = email;
    this._firstName = firstName;
    this._lastName = lastName;
    this._avatar = avatar;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get firstName => _firstName;
  set firstName(String? firstName) => _firstName = firstName;
  String? get lastName => _lastName;
  set lastName(String? lastName) => _lastName = lastName;
  String? get avatar => _avatar;
  set avatar(String? avatar) => _avatar = avatar;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['email'] = this._email;
    data['first_name'] = this._firstName;
    data['last_name'] = this._lastName;
    data['avatar'] = this._avatar;
    return data;
  }
}

class Support {
  String? _url;
  String? _text;

  Support({String? url, String? text}) {
    this._url = url;
    this._text = text;
  }

  String? get url => _url;
  set url(String? url) => _url = url;
  String? get text => _text;
  set text(String? text) => _text = text;

  Support.fromJson(Map<String, dynamic> json) {
    _url = json['url'];
    _text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this._url;
    data['text'] = this._text;
    return data;
  }
}
