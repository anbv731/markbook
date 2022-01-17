import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:markbook/new_to_do_screen.dart';
import 'package:markbook/preview.dart';
import 'package:markbook/services/DatabaseHandler.dart';
import 'package:markbook/to_do_screen.dart';
import 'package:provider/provider.dart';
import 'model.dart';

void main() {
  // runApp(
  //   const MaterialApp(
  //     title: 'Returning Data',
  //     home: HomeScreen(),
  //   ),
  // );
  runApp(ChangeNotifierProvider(
    create: (context) => ListOfToDoLists(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  DatabaseHandler handler = DatabaseHandler();
  List<MarkMapModel> marks = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('MyApp state = $state');
    if (state == AppLifecycleState.inactive) {
      // app transitioning to other state.
      marks = Provider.of<ListOfToDoLists>(context)
          .getList[0]
          .getData
          .map((e) => e.toMarkMapModel())
          .toList();
      handler.insertMark(marks);
      print(
          'length ${(await handler.retrieveMarks()).length}');
    } else if (state == AppLifecycleState.paused) {
      // app is on the background.
      marks = context
          .read<ListOfToDoLists>()
          .getList[0]
          .getData
          .map((e) => e.toMarkMapModel())
          .toList();
      handler.insertMark(marks);
      print(
          'length ${(await handler.retrieveMarks()).length}');
    } else if (state == AppLifecycleState.detached) {
      // flutter engine is running but detached from views
    } else if (state == AppLifecycleState.resumed) {
      //app is visible and running.
      context.read<ListOfToDoLists>().getList[0].newData(
        (await handler.retrieveMarks())
            .map((e) => MarkModel().fromMarkMapModel(e))
            .toList(),
      );
      context.read<ListOfToDoLists>().notifyListeners();
      runApp(MyApp()); // run your App class again
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      routes: {
        '/ToDoScreen': (context) => ToDoScreen(),
        '/newToDoScreenElse': (context) => NewToDoScreen(),
      },
      home: MainScreen(),
    );
  }
}

class Arguments {
  Arguments(this.newToDoList, this.marker);

  bool marker = false;
  ToDoListModel newToDoList = ToDoListModel();
}

class MainScreen extends StatelessWidget {
  ToDoListModel newToDoList = ToDoListModel();
  bool marker = true;
  DatabaseHandler handler = DatabaseHandler();
  List<MarkMapModel> marks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Preview Screen'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/newToDoScreenElse');
            },
            icon: Icon(Icons.add)),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        marks = context
            .read<ListOfToDoLists>()
            .getList[0]
            .getData
            .map((e) => e.toMarkMapModel())
            .toList();
        handler.insertMark(marks);
        print('length ${(await handler.retrieveMarks()).length}');
      }
          //     onPressed: () async {
          //   final result = await Navigator.pushNamed(
          //     context,
          //     '/newToDoScreen',
          //     arguments: Arguments(newToDoList, marker),
          //   );
          //   newToDoList = result as ToDoListModel;
          //   context.read<ListOfToDoLists>().addData(newToDoList);
          //   int a = newToDoList.getData.length;
          //   print('$a');
          //}
          ),
      body: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
          itemCount: context.watch<ListOfToDoLists>().getList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              background: Container(color: Colors.red),
              key: UniqueKey(),
              onDismissed: (DismissDirection direction) {
                context.read<ListOfToDoLists>().removeData(index);
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Preview(index)),
            );
          },
          staggeredTileBuilder: (index) {
            return StaggeredTile.fit(1);
          }),
    );
  }
}
