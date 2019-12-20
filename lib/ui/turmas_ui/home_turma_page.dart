import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parecer_app/models/turma_model.dart';
import 'package:parecer_app/repositories/turmas_data_repository.dart';
import 'package:parecer_app/ui/turmas_ui/cadastro_turma_page.dart';
import 'package:parecer_app/ui/turmas_ui/card_turma_page.dart';

import 'package:toast/toast.dart';

class HomeTurma extends StatefulWidget {

  String escolaId;

  HomeTurma({String escolaId}) {
    this.escolaId = escolaId;
  }

  @override
  _HomeTurmaState createState() => _HomeTurmaState(this.escolaId);
}

class _HomeTurmaState extends State<HomeTurma> {
  String escolaId;
  List<Turma> _turmas;
  TurmasDataRepository _turmasDataRepository;
  bool _isLoading;

  _HomeTurmaState(String id) {
    this.escolaId = id;
    _turmasDataRepository = TurmasDataRepository(escolaId);
  }

  @override
  void initState() {
    super.initState();
    this._isLoading = true;
    this.onLoadTurmasComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turmas"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: (this._turmas != null) ? this._turmas.length : 0,
        itemBuilder: (context, index) {
          return Container(
            child: Slidable(
                key: ValueKey(index),
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: <Widget>[
                  Container(
                    height: 100,
                    child: IconSlideAction(
                      caption: 'Editar',
                      color: Colors.grey.shade300,
                      icon: Icons.edit,
                      closeOnTap: false,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => AdicionaTurma(escolaId,
                                editar: true,
                                nomeTurma: _turmas[index].nome, turmaId: _turmas[index].id),
                            )
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    child: IconSlideAction(
                      caption: 'Deletar',
                      color: Colors.red,
                      icon: Icons.delete,
                      closeOnTap: true,
                      onTap: () {
                        setState(() {
                          removerTurma(_turmas[index].id);
                        });
                        Toast.show('Turma '+ _turmas[index].nome +' deletada ', context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
                      },
                    ),
                  )
                ],
                child: TurmaView(_turmas[index].nome,_turmas[index].id, escolaId)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdicionaTurma(this.escolaId),
              ));
        },
        tooltip: "Adicione uma turma",
        child: Icon(Icons.add),
      ),
    );
  }

  void onLoadTurmasComplete() {
    this._turmasDataRepository.buscaTodas().then((dados) => {
      this.setState(() {
        this._turmas = dados;
        this._isLoading = false;
      })
    });
  }
  
  void removerTurma(String idTurma){
      _turmasDataRepository.remove(idTurma);
      _turmasDataRepository.buscaTodas().then((turmas) =>{
      setState(() {
        this._turmas = turmas;
      })
      }
      );
  }
  

}
