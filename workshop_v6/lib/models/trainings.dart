class Training {
  int id;
  int idWorkshop;
  String name;
  String trainer;
  int note;
  Training(this.id, this.idWorkshop, this.name, this.trainer, this.note);
  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'idWorkshop': idWorkshop,
      'name': name,
      'trainer': trainer,
      'note': note,
    };
  }
}
