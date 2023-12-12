import 'package:flutter/material.dart';
import 'package:aplicativoescolas/models/criterio_model.dart';
import 'package:aplicativoescolas/repositories/criterio_data_repository.dart';
import 'criterios_linguagens_page.dart';

class CadastrarCriteriosLinguagensView extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  String turmaId;
  String escolaId;
  bool editar = false;
  String id;
  String desc;

  CriterioDataRepository _criterioDataRepository;

  CadastrarCriteriosLinguagensView(String turmaID, String escolaID,
      {bool editar, String id, String desc}) {
    this.turmaId = turmaID;
    this.escolaId = escolaID;
    this._criterioDataRepository = CriterioDataRepository(turmaId, escolaId);
    this.editar = editar;
    this.id = id;
    this.desc = desc;
    _textEditingController.text = desc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Critérios para linguagens"),
        backgroundColor: Colors.blue,
      ),
      body: _campoCadastroCriterios(context),
    );
  }

  Widget _campoCadastroCriterios(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 32, bottom: 0, right: 32, top: 15),
            child: TextField(
              style: TextStyle(
                fontSize: 17,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Informe um critério para linguagens",
              ),
              enabled: true,
              maxLength: 50,
              maxLengthEnforced: false,
              obscureText: false,
              onSubmitted: (String campoTextoEscola) {},
              controller: _textEditingController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.height,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // background
                ),
                child: Text(
                  "Cadastrar",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                onPressed: () {
                  if (editar == true) {
                    editarCriterio(id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CriterioLinguagensView(
                              turmaID: turmaId,
                              escolaID: escolaId,
                              titulo: "Linguagens"),
                        ));
                  } else {
                    String nome = _textEditingController.text;
                    adicionar(nome);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CriterioLinguagensView(
                              turmaID: turmaId,
                              escolaID: escolaId,
                              titulo: "Linguagens"),
                        ));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void adicionar(String descricao) {
    Criterio criterio = Criterio(descricao: descricao, areaRef: "LINGUAGENS");
    _criterioDataRepository.adiciona(criterio.toMap());
  }

  void editarCriterio(String id) {
    String novoTexto = _textEditingController.text;
    Criterio criterio =
        Criterio(descricao: novoTexto, areaRef: "LINGUAGENS", id: id);
    _criterioDataRepository.atualiza(criterio.toMap(), id);
  }
}
