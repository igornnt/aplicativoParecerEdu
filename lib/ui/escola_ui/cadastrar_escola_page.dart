import 'package:flutter/material.dart';
import 'package:parecer_app/models/escola_model.dart';
import 'package:parecer_app/repositories/escolas_data_repository.dart';
import 'home_escola_page.dart';

class CadastrarEscolaView extends StatelessWidget {

  bool editar;
  String id;
  TextEditingController _textEditingController = TextEditingController();
  EscolasDataRepository _repository = new EscolasDataRepository();

  CadastrarEscolaView({bool editar , String textoParaAtualizar,String id}) {

    this._textEditingController.text = "";

    if(editar == true) {
      this.editar = true;
      this.id = id;
      this._textEditingController.text = textoParaAtualizar;
    }else{
      this.editar = false;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar escola"),
        backgroundColor: Colors.blue,
      ),
      body: campoCadastroEscola(context),
    );
  }

  Widget campoCadastroEscola (BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 32, bottom: 0, right: 32, top: 15 ),
            child: TextField(
              style: TextStyle(
                fontSize: 17,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Informe o nome da escola",
              ),
              enabled: true,
              maxLength: 50,
              maxLengthEnforced: false,
              obscureText: false,
              onSubmitted: (String campoTextoEscola) {
                print("foi digitado: $campoTextoEscola");
              },
              controller: _textEditingController,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(32),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.height,
              child: RaisedButton(
                color: Colors.blue,
                child: Text("Cadastrar", style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
                ),
                onPressed: () {
                  if(editar == false){
                    cadastrarNovaEscola();
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => HomeInicial(),
                        )
                    );
                  }else
                    atualizarEscola();
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => HomeInicial(),
                        )
                    );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void cadastrarNovaEscola(){
      String nomeNovaEscola = _textEditingController.text;
      Escola escolaNova = Escola(nome: nomeNovaEscola);
      _repository.adiciona(escolaNova.toMap());
  }

  void atualizarEscola(){
    String nome = _textEditingController.text;
    Escola escola = Escola(nome: nome);
    _repository.atualiza(escola.toMap(), id);
  }

}
