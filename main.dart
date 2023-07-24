import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'WorkOutApp',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/challenge.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'WorkOutApp',
        ),
        backgroundColor: Colors.amber.shade100,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
            itemCount: _items.length,
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              // setState(() {
              //   activePage = page;
              // });
            },
            itemBuilder: (context, pagePosition) {
              return Container(
                  margin: EdgeInsets.all(20),
                  child: SizedBox(
                    child: Column(
                      children: [
                        Image.network(_items[pagePosition]["photo"]),
                        Text(_items[pagePosition]["challengeName"]),
                        Text(_items[pagePosition]["coachName"]),
                        ElevatedButton(
                            onPressed: () {}, child: Text("start challenge")),
                        SizedBox(
                          child: Column(
                            children: [
                              Text("About this challenge"),
                              SizedBox(
                                width: 700,
                                height: 100,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(_items[pagePosition]
                                          ["aboutChallenge"]),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Card(
                        //   margin: const EdgeInsets.all(10),
                        //   color: Colors.amber.shade100,
                        //   child: ListTile(
                        //     // leading: Text(_items[pagePosition]["id"]),
                        //     title: Text("Instructor"),
                        //     subtitle: Text(_items[pagePosition]["coachName"]),
                        //     trailing: Text("blabla"),
                        //   ),
                        // )
                        Container(
                          child: Column(
                            children: [
                              //Image.network(_items[pagePosition]["photo"]),
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage: NetworkImage(
                                      _items[pagePosition]["coachPhoto"]),
                                ),
                                title: Text("Instructor"),
                                subtitle:
                                    Text(_items[pagePosition]["coachName"]),
                                //trailing: Text("blabla"),
                              ),
                              SizedBox(
                                child: Column(
                                  children: [
                                    //Text("About this challenge"),
                                    SizedBox(
                                      width: 700,
                                      height: 100,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(_items[pagePosition]
                                                ["coachDiscreption"]),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text("difficulty"),
                                Text(_items[pagePosition]["difficulty"])
                              ],
                            ),
                            Column(
                              children: [
                                Text("intensity"),
                                Text(_items[pagePosition]["intensity"])
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                  // Card(
                  //                 key: ValueKey(_items[pagePosition]["id"]),
                  //                 margin: const EdgeInsets.all(10),
                  //                 color: Colors.amber.shade100,
                  //                 child: ListTile(
                  //                   leading: Text(_items[pagePosition]["id"]),
                  //                   title: Text(_items[pagePosition]["name"]),
                  //                   subtitle: Text(_items[pagePosition]["description"]),
                  //                 ),
                  //               )
                  );
            }),
      ),
      // SingleChildScrollView(
      //   physics: const ScrollPhysics(),
      //   scrollDirection: Axis.horizontal,
      //   child:
      //   Padding(
      //     padding: const EdgeInsets.all(0),
      //     child: Column(
      //       children: [
      //         // Display the data loaded from sample.json
      //         _items.isNotEmpty
      //             ? Expanded(
      //                 child: ListView.builder(
      //                   itemCount: _items.length,
      //                   itemBuilder: (context, index) {
      //                     return Card(
      //                       key: ValueKey(_items[index]["id"]),
      //                       margin: const EdgeInsets.all(10),
      //                       color: Colors.amber.shade100,
      //                       child: ListTile(
      //                         leading: Text(_items[index]["id"]),
      //                         title: Text(_items[index]["name"]),
      //                         subtitle: Text(_items[index]["description"]),
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               )
      //             : Container()
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
