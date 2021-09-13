import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:contact_list/appModel.dart';
import 'package:contact_list/contact_list/contact_list_view.dart';
import 'package:contact_list/contact_list/contact_list_view_model.dart';
import 'package:contact_list/no_internet/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

final GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();
final routeObserver = RouteObserver<PageRoute>();

class AppState extends State<App> /*with WidgetsBindingObserver*/ {
  static late BuildContext appContext;
  final _app = AppModel();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  var id;
  late StreamSubscription<ConnectivityResult> subscription;
  final Connectivity _connectivity = Connectivity();
  var isLaunch = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  void initState() {
    super.initState();
    subscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      // Got a new connectivity status!
      result = await _connectivity.checkConnectivity();
      print("network changed: " + result.toString());

      if (!isLaunch) {
        if (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile) {
          print("back");
          Navigator.pop(mainNavigatorKey.currentContext!);
        } else {
          print("push");
          Navigator.push(
            mainNavigatorKey.currentContext!,
            MaterialPageRoute(builder: (context) => NoInternetView()),
          );
        }
      } else {
        print("is firsttime false");
        isLaunch = false;
        if (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile) {
        } else {
          print("push");
          Navigator.push(
            mainNavigatorKey.currentContext!,
            MaterialPageRoute(builder: (context) => NoInternetView()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    appContext = context;
    return ChangeNotifierProvider<AppModel>.value(
      value: _app,
      child: Consumer<AppModel>(
        builder: (context, value, child) {
          value.isLoading = false;
          if (value.isLoading) {
            return Container(
              color: Theme.of(context).backgroundColor,
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ContactListViewModel>(
                  create: (_) => ContactListViewModel())
            ],
            child: MaterialApp(
              builder: (BuildContext context, Widget? child) {
                final MediaQueryData data = MediaQuery.of(context);
                return MediaQuery(
                    child: child!, data: data.copyWith(textScaleFactor: 1));
              },
              title: 'Contact List',
              navigatorKey: mainNavigatorKey,
              navigatorObservers: [routeObserver],
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              home: ContactListView(),
              routes: <String, WidgetBuilder>{},
            ),
          );
        },
      ),
    );
  }
}
