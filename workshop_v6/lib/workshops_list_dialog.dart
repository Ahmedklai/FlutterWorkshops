import 'package:flutter/material.dart';
import 'util/dbhelper.dart';
import 'package:workshop_v6/models/workshops_list.dart';

class WorkshopsListDialog {
  final txtName = TextEditingController();
  final txtPriority = TextEditingController();
  Widget buildDialog(BuildContext context, WorkshopsList list, bool isNew) {
    DbHelper helper = DbHelper();
    if (!isNew) {
      txtName.text = list.name;
      txtPriority.text = list.priority.toString();
    }
    return AlertDialog(
      title: Text((isNew) ? 'New Workshops list' : 'Edit sorkshops list'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: InputDecoration(hintText: 'Workshops List Name'),
            ),
            TextField(
              controller: txtPriority,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(hintText: 'Workshops List Priority (1-4)'),
            ),
            RaisedButton(
              child: Text('Save Workshops List'),
              onPressed: () async {
                await helper.openDb();
                list.name = txtName.text;
                list.priority = int.parse(txtPriority.text);
                helper.insertList(list);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
