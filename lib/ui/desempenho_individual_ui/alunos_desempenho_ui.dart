
import 'package:flutter/material.dart';
import 'package:parecer_app/models/aluno_model.dart';
import 'package:parecer_app/repositories/alunos_data_repository.dart';
import 'package:parecer_app/ui/desempenho_individual_ui/desempenho_individual_page.dart';

class AlunoViewChart extends StatefulWidget {

  String escolaId;
  String turmaId;

  AlunoViewChart(turmaId, escolaId) {
    this.escolaId = escolaId;
    this.turmaId = turmaId;
  }

  @override
  _AdicionarAlunoViewState createState() => _AdicionarAlunoViewState(escolaId, turmaId);
}

class _AdicionarAlunoViewState extends State<AlunoViewChart> {
  String escolaId;
  String turmaId;
  AlunosDataRepository _alunosDataRepository;
  List<Aluno> alunos;

  bool _isLoading;

  _AdicionarAlunoViewState(escolaId, turmaId) {
    this.escolaId = escolaId;
    this.turmaId = turmaId;

    _alunosDataRepository = AlunosDataRepository(turmaId, escolaId);
  }

  @override
  void initState() {
    super.initState();
    this._isLoading = true;
    this.onLoadAlunosComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alunos"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: (this.alunos != null) ? this.alunos.length : 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(
                        builder: (context) => DesempenhoIndividual(this.escolaId, this.turmaId, alunos[index].id)
                    ),
                    );
                  },
                  child: Container(
                    child:ListTile(
                          title: Text(alunos[index].getNomeAluno()),
                    )
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void onLoadAlunosComplete() {
    this._alunosDataRepository.buscaTodas().then((dados) => {
      this.setState(() {
        this.alunos = dados;
      })
    });
  }
}
