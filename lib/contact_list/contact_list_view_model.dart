import 'package:contact_list/model/user_list_model.dart';
import 'package:contact_list/services/base_services.dart';
import 'package:flutter/cupertino.dart';

class ContactListViewModel extends ChangeNotifier {
  Services services = Services();
  BuildContext? mContext;
  UserListMaster? userListMaster;
  List<Data?>? dataList = [];

  void attachConatext(BuildContext context) {
    mContext = context;
    getContactList(1);
  }

  void setGlobalKey() {}

  Future<void> getContactList(page) async {
    userListMaster = await services.getConatctList(page);
    if (userListMaster != null) {
      dataList!.addAll(userListMaster!.data!);
    }
    notifyListeners();
  }
}
