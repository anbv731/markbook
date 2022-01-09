import 'package:flutter/material.dart';
import 'package:markbook/marks_screen.dart';
import 'package:markbook/model.dart';
import 'package:provider/provider.dart';

class ToDoScreen extends StatelessWidget {
  int upIndex = -1;

  @override
  Widget build(BuildContext context) {
    upIndex = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.done))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newToDoScreenElse',
              arguments: upIndex);
        },
        child: Icon(Icons.edit),
      ),
      body: ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) {
          context
              .read<ListOfToDoLists>()
              .getList[upIndex]
              .insertData(oldIndex, newIndex);
        },
        shrinkWrap: true,
        itemCount:
            context.watch<ListOfToDoLists>().getList[upIndex].getData.length,
        itemBuilder: (context, int index) {
          return MarkTextField(
            upIndex,
            index,
          );
        },
      ),
    );
  }
}
