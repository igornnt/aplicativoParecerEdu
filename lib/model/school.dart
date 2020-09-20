
class School {

  int id;
  String name;

  School({this.id, this.name});

  factory School.fromMap(Map<String, dynamic> json) => new School(
    id: json['id'],
    name: json['name']
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name
  };

}