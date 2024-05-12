import 'package:flutter/material.dart';

import '../../../../utils/app_methods/app_methods.dart';
import '../../../../utils/app_variables/app_vars.dart';
import '../../../widgets/appbar_default_widget.dart';
import '../../newsfeed_page.dart';

class LeaveCards extends StatefulWidget {
  final String? title;
  const LeaveCards({super.key, this.title});

  @override
  State<LeaveCards> createState() => _LeaveCardsState();
}

class _LeaveCardsState extends State<LeaveCards>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  Widget pendingRequests() {
    return Column(
      children: List.generate(
          10,
          (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Card(
                    elevation:
                        0, // Set Card's elevation to 0 to prevent shadow overlap
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text('Employee Name'),
                          subtitle: Text('Name'),
                          trailing: Text('Date'),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Leave: '),
                                    Text('Duration: '),
                                    Text('Leave Date: '),
                                    Text('Leave Balance: '),
                                    Text('Reason: '),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Leave: '),
                                    Text('Duration: '),
                                    Text('Leave Date: '),
                                    Text('Leave Balance: '),
                                    Text('Reason: '),
                                  ],
                                ),
                              ],
                            )),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                print("Approve");
                              },
                              child: Text('Approve'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                AppMethods.showAlertPop(
                                    context,
                                    Text(
                                      "Are you sure?",
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      width: AppVars.screenSize.width * 0.9,
                                      child: Text(
                                        "Do you want to delete this request?\n\nEmployee Name:Sajjad\nReason:this",
                                        textAlign: TextAlign.center,
                                        //maxLines: 3,
                                        // overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    () {},
                                    () {});
                                print("Reject");
                              },
                              child: Text('Reject'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                              ),
                            ),
                            /* TextButton(
                              onPressed: () {
                                print("Edit");
                              },
                              child: Text('Edit'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                              ),
                            ), */
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  Widget historyList() {
    return Center(child: Text('History'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.title == null)
          ? null
          : AppbarDefault(
              appbarName: widget.title,
            ),

      /* AppBar(
        centerTitle: true,
        title: Text('Leave Request'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
                child: Text(
              'Pending Request',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
            Tab(
              child: Text(
                'History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ), */
      /* (widget.title == null)
          ? null
          : AppbarDefault(
              appbarName: widget.title,
            ), */
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                  child: Text(
                'Pending Request',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
              Tab(
                child: Text(
                  'History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: AppVars.screenSize.height * 0.8,
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(child: pendingRequests()),
                NewsfeedPage() /* Center(child: Text('History')) */,
              ],
            ),
          ),
        ],
      ), /* ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return 
        },
      ), */
    );
  }
}
