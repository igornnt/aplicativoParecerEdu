
class Escola {
  
  String _nome;
  
  int _qtdTurmas;

  Escola(this._nome){
   this._qtdTurmas = 0;
  }

  String getNomeEscola(){
    return this._nome;
  }

  int getQudAlunos(){
    return _qtdTurmas;
  }

}