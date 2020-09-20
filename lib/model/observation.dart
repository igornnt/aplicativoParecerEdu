

class Observation {

  int id;
  int idStudent;
  String observation;
  int ano;
  int mes;
  int dia;

  Observation({this.id, this.idStudent, this.observation, this.ano, this.mes, this.dia});

  factory Observation.fromMap(Map<String, dynamic> json) => new Observation(
      id: json['id'],
      idStudent: json['idStudent'],
      observation: json['observation'],
      ano: json['ano'],
      mes: json['mes'],
      dia: json['dia']
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'idStudent': idStudent,
    'observation': observation,
    'ano': ano,
    'mes': mes,
    'dia': dia
  };

}