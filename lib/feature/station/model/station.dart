class Station {
  String? id;
  String name;
  int role;

  Station({this.id, required this.name, required this.role});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'role': role,
    };
  }

  factory Station.fromMap(String id, Map<String, dynamic> map) {
    return Station(
      id: id,
      name: map['name'] as String,
      role: map['role'] as int,
    );
  }
}
