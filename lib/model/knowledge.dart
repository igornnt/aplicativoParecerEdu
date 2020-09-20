class Knowledge{

  int id;
  String criterio;
  int idArea;
  int idTurma;
  int isAvaliado;

  Knowledge({this.id, this.criterio, this.idArea, this.idTurma, this.isAvaliado});

  factory Knowledge.fromMap(Map<String, dynamic> json) => new Knowledge(
      id: json['id'],
      criterio: json['criterio'],
      idArea: json['idArea'],
      idTurma: json['idTurma'],
      isAvaliado: json['isAvaliado'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'criterio': criterio,
    'idArea': idArea,
    'idTurma': idTurma,
    'isAvaliado': isAvaliado
  };

}