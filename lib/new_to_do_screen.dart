import 'package:flutter/material.dart';
import 'package:markbook/marks_screen.dart';
import 'package:markbook/model.dart';
import 'package:provider/provider.dart';

class NewToDoScreen extends StatelessWidget {
  final ValueNotifier<bool> a = ValueNotifier<bool>(true);
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(210, 186, 136, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: textController,
                  onSubmitted: (newNote) {
                    if (a.value == true) {
                      context.read<ListOfToDoLists>().addList();
                      a.value = false;
                    }
                    context.read<ListOfToDoLists>().getList.last.addMark();
                    context
                        .read<ListOfToDoLists>()
                        .getList
                        .last
                        .getData
                        .last
                        .changeNote(newNote);
                    context.read<ListOfToDoLists>().notifyListeners();
                    textController.clear();
                  },
                ),
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: a,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return a.value
                        ? SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: context
                                .watch<ListOfToDoLists>()
                                .getList
                                .last
                                .getData
                                .length,
                            //toDoList.getData.length,
                            itemBuilder: (context, int index) {
                              return Mark(
                                  index,
                                  context
                                          .read<ListOfToDoLists>()
                                          .getList
                                          .length -
                                      1,
                                  true);
                            },
                          );
                  })
            ],
          ),
        ],
      ),
    );
  }
}
