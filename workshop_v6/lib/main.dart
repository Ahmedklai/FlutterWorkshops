//main.dart
import 'package:flutter/material.dart';
import 'package:workshop_v6/trainigs_screen.dart';
import 'workshops_list_dialog.dart';
import './models/workshops_list.dart';
import 'util/dbhelper.dart';

void main() {
  runApp(MaterialApp(home: WkList()));
}

class WkList extends StatefulWidget {
  @override
  _WkListState createState() => _WkListState();
}

class _WkListState extends State<WkList> {
  WorkshopsListDialog dialog;
  @override
  void initState() {
    dialog = WorkshopsListDialog();
    super.initState();
  }

  DbHelper helper = DbHelper();
  List<WorkshopsList> workshopsList;

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Workshops List'),
      ),
      body: ListView.builder(
          itemCount: (workshopsList != null) ? workshopsList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(workshopsList[index].name),
              onDismissed: (direction) {
                String strName = workshopsList[index].name;
                helper.deleteList(workshopsList[index]);
                setState(() {
                  workshopsList.removeAt(index);
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("$strName deleted")));
              },
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrainingScreen(
                                workshopsList: workshopsList[index],
                              )),
                    );
                  },
                  child: ListTile(title: Text((workshopsList[index].name)))),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                dialog.buildDialog(context, WorkshopsList(0, 'hth', 0), true),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }

  Future showData() async {
    await helper.openDb();
    workshopsList = await helper.getLists();
    setState(() {
      workshopsList = workshopsList;
    });
  }
}
