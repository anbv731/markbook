import 'package:flutter/material.dart';
import 'package:markbook/model.dart';
import 'package:provider/provider.dart';

class Preview extends StatelessWidget {
  Preview(this.upIndex);

  int upIndex = -1;
  bool _marker = false;

  @override
  Widget build(BuildContext context) {
    ToDoListModel _toDoList = context.watch<ListOfToDoLists>().getList[upIndex];
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.pushNamed(
          context,
          '/ToDoScreen',
          arguments: upIndex,
        );
        context.read<ListOfToDoLists>().addData(result as ToDoListModel);
      },
      child: Container(
        constraints: BoxConstraints(maxHeight: 90),
        padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 2),
        decoration: BoxDecoration(
            color: Color.fromRGBO(205, 186, 136, 1),
            borderRadius: BorderRadius.circular(10)),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              context.watch<ListOfToDoLists>().getList[upIndex].getData.length,
          itemBuilder: (context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: context
                          .watch<ListOfToDoLists>()
                          .getList[upIndex]
                          .getData[index]
                          .getPriority
                      ? Icon(Icons.priority_high, color: Colors.red, size: 20)
                      : Icon(
                          Icons.priority_high,
                          color: Colors.grey,
                          size: 20,
                        ),
                ),
                Expanded(
                  child: Text(
                    context
                        .watch<ListOfToDoLists>()
                        .getList[upIndex]
                        .getData[index]
                        .getNote,
                    style: context
                            .watch<ListOfToDoLists>()
                            .getList[upIndex]
                            .getData[index]
                            .getDone
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                        : null,
                  ),
                ),
                Align(
                  alignment: FractionalOffset(1, 1),
                  child: context
                          .watch<ListOfToDoLists>()
                          .getList[upIndex]
                          .getData[index]
                          .getDone
                      ? Icon(Icons.done, color: Colors.red, size: 20)
                      : Icon(
                          Icons.done,
                          color: Colors.grey,
                          size: 20,
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
