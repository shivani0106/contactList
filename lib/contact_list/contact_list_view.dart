import 'package:contact_list/contact_list/contact_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactListView extends StatefulWidget {
  ContactListView({Key? key}) : super(key: key);

  @override
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  ContactListViewModel? contactListViewModel;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      contactListViewModel =
          Provider.of<ContactListViewModel>(context, listen: false);
      contactListViewModel!.attachConatext(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contactListViewModel = Provider.of<ContactListViewModel>(context);
    contactListViewModel!.mContext = context;

    final _myConatListView = ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: contactListViewModel!.dataList!.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            contactListViewModel!.dataList![i]!.avatar!,
                            fit: BoxFit.contain,
                          ),
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: Colors.amber),
                            ),
                            Text(contactListViewModel!
                                    .dataList![i]!.firstName! +
                                contactListViewModel!.dataList![i]!.lastName!),
                          ],
                        ),
                        Text(contactListViewModel!.dataList![i]!.email!)
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });

    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [_myConatListView],
      ),
    ));
  }
}
