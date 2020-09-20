class Evaluation {

  int id;
  int idArea;
  int idCriterio;
  int idClassSchool;
  String criterio;
  int idAluno;
  double peso;

  Evaluation({this.id, this.idArea, this.idCriterio,this.criterio,this.idAluno, this.peso, this.idClassSchool});

  factory Evaluation.fromMap(Map<String, dynamic> json) => new Evaluation(
      id: json['id'],
      idArea: json['idArea'],
      idCriterio: json['idCriterio'],
      idClassSchool: json['idClassSchool'],
      criterio: json['criterio'],
      idAluno: json['idAluno'],
      peso: json['peso']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'idArea': idArea,
        'idCriterio': idCriterio,
        'idClassSchool': idClassSchool,
        'criterio': criterio,
        'idAluno': idAluno,
        'peso': peso
      };
}
