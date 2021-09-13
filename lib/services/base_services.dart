import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:contact_list/model/user_list_model.dart';
import 'package:http/http.dart' as http;

class Services {
  Future<UserListMaster?> getConatctList(int? page) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final http.Response response = await http.get(
            Uri.parse("https://reqres.in/api/users?page=" + page.toString()));

        if (response.statusCode == 200) {
          print(response.request!.url);
          print(response.body);
          return UserListMaster.fromJson(json.decode(response.body));
        }
      } catch (e) {
        print("Error" + e.toString());
        return null;
      }
    } else {
      return null;
    }
  }
}
