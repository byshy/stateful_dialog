import 'package:flutter/material.dart';
import 'package:stateful_dialog/extras.dart';

import 'options.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Extra> extras;

  @override
  void initState() {
    super.initState();
    extras = List.generate(
      10,
      (index) => Extra(
        id: '$index',
        name: 'extra $index',
        options: List.generate(
          10,
          (innerIndex) => Options(
            id: '${innerIndex + index}',
            name: 'Options ${innerIndex + index}',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Text('Hi'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showStatefulDialog(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  String selectedId;

  void showStatefulDialog() {
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (_, state) {
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Title'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: extras.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) => Column(
                        children: [
                          Text('${extras[index].name}'),
                          ListView.builder(
                            itemCount: extras[index].options.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (_, innerIndex) => ListTile(
                              title: Text('${extras[index].options[innerIndex].name}'),
                              selected: selectedId == extras[index].options[innerIndex].id,
                              onTap: () {
                                state(() {
                                  selectedId = extras[index].options[innerIndex].id;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
