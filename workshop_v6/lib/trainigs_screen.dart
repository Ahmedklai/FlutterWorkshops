import 'package:flutter/material.dart';
import 'package:workshop_v6/models/trainings.dart';
import 'models/workshops_list.dart';
import 'util/dbhelper.dart';

class TrainingScreen extends StatefulWidget {
  final WorkshopsList workshopsList;

  const TrainingScreen({Key key, this.workshopsList}) : super(key: key);

  @override
  _TrainingScreenState createState() =>
      _TrainingScreenState(this.workshopsList);
}

class _TrainingScreenState extends State<TrainingScreen> {
  final WorkshopsList workshopsList;

  _TrainingScreenState(this.workshopsList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(workshopsList.name),
        ),
        body: Container());
  }
}
