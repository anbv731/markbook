import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:markbook/new_to_do_screen.dart';
import 'package:markbook/preview.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListOfToDoLists>(
            create: (context) => ListOfToDoLists()),
        ChangeNotifierProvider<X>(create: (context) => X()),
        ChangeNotifierProvider<Y>(create: (context) => Y())
      ],
      child: MaterialApp(
        routes: {
          '/ToDoScreen': (context) => ToDoScreen(),
          '/newToDoScreenElse': (context) => NewToDoScreen(),
        },
        home: MainScreen(),
      ),
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
        final result = await Navigator.pushNamed(
          context,
          '/newToDoScreen',
          arguments: Arguments(newToDoList, marker),
        );
        newToDoList = result as ToDoListModel;
        context.read<ListOfToDoLists>().addData(newToDoList);
        int a = newToDoList.getData.length;
        print('$a');
      }),
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


