class Student{

  int id;

  int idClass;

  String name;

  Student({this.id, this.name, this.idClass});

  factory Student.fromMap(Map<String, dynamic> json) => new Student(
      id: json['id'],
      idClass: json['idClass'],
      name: json['name']
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'idClass': idClass,
    'name': name
  };

}