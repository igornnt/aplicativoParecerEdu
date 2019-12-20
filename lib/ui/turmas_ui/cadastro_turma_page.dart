import 'package:flutter/material.dart';
import 'package:parecer_app/models/turma_model.dart';
import 'package:parecer_app/repositories/turmas_data_repository.dart';
import 'package:parecer_app/ui/turmas_ui/home_turma_page.dart';

class AdicionaTurma extends StatelessWidget {

  String escolaId;
  String turmaId;
  bool editar;
  String nomeTurmaAtualizar;

  TurmasDataRepository turmasDataRepository;

  TextEditingController _textTurmaEditingController = TextEditingController();


  AdicionaTurma(String idEscola, {String turmaId, bool editar, String nomeTurma}){

    this.escolaId = idEscola;

    turmasDataRepository = TurmasDataRepository(escolaId);

    _textTurmaEditingController.text = "";

    if(editar == true) {
      this.turmaId = turmaId;
      this.editar = true;
      this.nomeTurmaAtualizar = nomeTurma;
      _textTurmaEditingController.text = nomeTurma;
    }else{
      this.editar = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar turma"),
        backgroundColor: Colors.blue,
      ),
      body: campoCadastroTurma(context),
    );
  }

  Widget campoCadastroTurma (BuildContext context){

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 32, bottom: 0, right: 32, top: 15 ),
            child: TextField(
              //Definir o tipo de teclado que será digitado
              style: TextStyle(
                fontSize: 17,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Informe o nome da turma",
              ),
              //Habilitar a digitação
              enabled: true,
              //quantidade de caracteres digitados 2/100
              maxLength: 50,
              // Não consigo enviar sem que a quantidade estabelicida
              maxLengthEnforced: false,
              //Usado para esconder caracteres
              obscureText: false,
              controller: _textTurmaEditingController,
            ),
          ),
          //Criando meu botão para enviar os dados
          Padding(
            padding: const EdgeInsets.all(32),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.height,
              child: RaisedButton(
                //Cor do botão
                color: Colors.blue,
                //O Texto que vai nele
                child: Text("Cadastrar", style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                ),),
                //A função que será digitada
                onPressed: (){
                  if(editar == false){
                    salvarTurma();
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => HomeTurma(escolaId: escolaId),
                        )
                    );
                  }else{
                    editarTurma();
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => HomeTurma(escolaId: escolaId),
                        )
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void salvarTurma(){
    String texto = _textTurmaEditingController.text;
    Turma turma = Turma();
    turma.nome = texto;
    turmasDataRepository.adiciona(turma.toMap());
  }

  void editarTurma(){
    String nome = _textTurmaEditingController.text;
    Turma turma = Turma();
    turma.nome = nome;
    turmasDataRepository.atualiza(turma.toMap(), turmaId);

  }

}
