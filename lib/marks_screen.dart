

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markbook/model.dart';
import 'package:provider/provider.dart';

class MarkTextField extends StatelessWidget {
  MarkTextField(this.upIndex, this.index);

  Key key = UniqueKey();

  int upIndex = -1;

  int index = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => {
              context
                  .read<ListOfToDoLists>()
                  .getList[upIndex]
                  .getData[index]
                  .changePriority(),
              context.read<ListOfToDoLists>().notifyListeners(),
            },
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
        ),
        Expanded(
            child: TextFormField(
          initialValue: context
              .watch<ListOfToDoLists>()
              .getList[upIndex]
              .getData[index]
              .getNote,
          onFieldSubmitted: (newNote) {
            context
                .read<ListOfToDoLists>()
                .getList[upIndex]
                .getData[index]
                .changeNote(newNote);
            context.read<ListOfToDoLists>().notifyListeners();
          },
        )),
        Align(
          alignment: FractionalOffset(1, 1),
          child: GestureDetector(
            onTap: () => {
              context
                  .read<ListOfToDoLists>()
                  .getList[upIndex]
                  .getData[index]
                  .changeDone(),
              context.read<ListOfToDoLists>().notifyListeners()
            },
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
        ),
      ],
    ));
  }
}

class Mark extends StatelessWidget {
  Mark(this.index, this.upIndex, this.isEditable);

  bool isEditable;
  int upIndex = -1;

  int index = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => isEditable
                ? {
                    context
                        .read<ListOfToDoLists>()
                        .getList[upIndex]
                        .getData[index]
                        .changePriority(),
                    context.read<ListOfToDoLists>().notifyListeners(),
                  }
                : {},
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
          child: GestureDetector(
            onTap: () => isEditable
                ? {
                    context
                        .read<ListOfToDoLists>()
                        .getList[upIndex]
                        .getData[index]
                        .changeDone(),
                    context.read<ListOfToDoLists>().notifyListeners()
                  }
                : {},
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
        ),
      ],
    ));
  }
}




