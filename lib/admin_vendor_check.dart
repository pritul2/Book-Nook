import 'package:flutter/material.dart';

import 'admin_homepage.dart';
import 'api_helpers/approve_vendors.dart';
import 'api_helpers/get_vendors.dart';

class AdminVendorCheck extends StatefulWidget {
  const AdminVendorCheck({Key? key}) : super(key: key);

  @override
  _AdminVendorCheckState createState() => _AdminVendorCheckState();
}

class _AdminVendorCheckState extends State<AdminVendorCheck> {
  List<dynamic> _businesses = [];
  bool _seeVendors = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getVendors();
  }

  Future<void> _getVendors() async {
    Map<String, dynamic> response = await getVendors('36');
    print("VENDORSSS");
    if ((response["Results"] as List<dynamic>).isNotEmpty) {
      setState(() {
        _businesses = response["Results"];
        print(_businesses);

        _seeVendors = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Approve Vendors'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => AdminHomePage())));
                },
                icon: const Icon(Icons.menu_book_sharp)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.business))
          ],
        ),
        body: _seeVendors
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _businesses.length,
                        itemBuilder: (BuildContext context, int index) {
                          final business = _businesses[index];

                          return Dismissible(
                            key: Key(business["Name"]),
                            onDismissed: (_) {
                              setState(() {
                                _businesses.removeAt(index);
                              });
                            },
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              child: Icon(Icons.delete, color: Colors.white),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 16),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                    "${business["Name"]} - ${business["company"]}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.check),
                                      onPressed: () async {
                                        await approveVendors(
                                            '36', business['username'], true);
                                        setState(() {
                                          _businesses.removeAt(index);
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () async {
                                        await approveVendors(
                                            '36', business['username'], false);
                                        setState(() {
                                          _businesses.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : Center(child: Text('No Vendors to Approve.')));
  }
}
