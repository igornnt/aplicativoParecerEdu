
class ClassSchool{

  int id;
  String name;
  int idSchool;

  ClassSchool({this.id, this.name, this.idSchool});

  factory ClassSchool.fromMap(Map<String, dynamic> json) => new ClassSchool(
      id: json['id'],
      name: json['name'],
      idSchool: json['idSchool']
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'idSchool': idSchool
  };


}