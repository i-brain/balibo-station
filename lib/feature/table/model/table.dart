class TableModel {
  String? id;
  int number;
  int status;

  TableModel({this.id, required this.number, required this.status});

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'status': status,
    };
  }

  factory TableModel.fromMap(String id, Map<String, dynamic> map) {
    return TableModel(
      id: id,
      number: map['number'],
      status: map['status'],
    );
  }
}
