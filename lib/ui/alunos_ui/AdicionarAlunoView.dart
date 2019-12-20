import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parecer_app/models/aluno_model.dart';
import 'package:parecer_app/repositories/alunos_data_repository.dart';
import 'package:toast/toast.dart';

class AdicionarAlunoView extends StatefulWidget {
  String escolaId;
  String turmaId;

  AdicionarAlunoView(this.turmaId, this.escolaId) {
    this.escolaId = escolaId;
    this.turmaId = turmaId;
  }

  @override
  _AdicionarAlunoViewState createState() =>
      _AdicionarAlunoViewState(escolaId, turmaId);
}

class _AdicionarAlunoViewState extends State<AdicionarAlunoView> {
  String escolaId;
  String turmaId;
  AlunosDataRepository _alunosDataRepository;

  _AdicionarAlunoViewState(this.escolaId, this.turmaId) {
    this.escolaId = escolaId;
    this.turmaId = turmaId;
    _alunosDataRepository = AlunosDataRepository(turmaId, escolaId);
  }

  TextEditingController _alunoTextEditingController =
      new TextEditingController();

  List<Aluno> alunos;

  bool _isLoading;

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
        elevation: 0.2,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: (this.alunos != null) ? this.alunos.length : 0,
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
                              _alunoTextEditingController.text = "";
                              _alunoTextEditingController.text =
                                  alunos[index].nome;
                              show(limpar: false, indexe: index);
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
                              removerAluno(alunos[index].id);
                              Toast.show('removido com sucesso', context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);
                            },
                          ),
                        )
                      ],
                      child: Container(
                          decoration: BoxDecoration(
                            border: new BorderDirectional(bottom: BorderSide(
                              color: Colors.blue.shade100,
                              width: 1.5,
                            ),
                            )
                          ),
                        child: ListTile(
                          title: Text(alunos[index].getNomeAluno()),
                        ),
                      )),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          show(limpar: true);
        },
      ),
      //bottomNavigationBar: BottomNavigationBar(items: null,),
    );
  }

  void onLoadAlunosComplete() {
    this._alunosDataRepository.buscaTodas().then((dados) => {
          this.setState(() {
            this.alunos = dados;
          })
        });
  }

  void salvarAluno(Aluno aluno) {
    this._alunosDataRepository.adiciona(aluno.toMap());
    onLoadAlunosComplete();
  }

  void editarAluno(Aluno aluno, String id) {
    this._alunosDataRepository.atualiza(aluno.toMap(), id);
    onLoadAlunosComplete();
  }

  void removerAluno(String id) {
    this._alunosDataRepository.remove(id);
    onLoadAlunosComplete();
  }

  void show({bool limpar, int indexe}) {
    if (limpar == true) {
      _alunoTextEditingController.text = "";
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Adicionar Aluno"),
              content: TextField(
                decoration:
                InputDecoration(labelText: ("Informe o nome do aluno")),
                controller: _alunoTextEditingController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      Aluno aluno =
                      new Aluno(nome: _alunoTextEditingController.text);
                      salvarAluno(aluno);
                      Navigator.pop(context);
                      _alunoTextEditingController.text = "";
                    }
                )
              ],
            );
          }
      );
    }

    if (limpar == false) {
      int index = indexe;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Adicionar Aluno"),
              content: TextField(
                decoration:
                    InputDecoration(labelText: ("Informe o nome do aluno")),
                controller: _alunoTextEditingController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      if (limpar == false) {
                        Aluno aluno = Aluno();
                        aluno.nome = _alunoTextEditingController.text;
                        editarAluno(aluno, alunos[index].id);
                        Navigator.pop(context);
                      }
                      if (limpar == true) {
                        Aluno aluno =
                            new Aluno(nome: _alunoTextEditingController.text);
                        salvarAluno(aluno);
                        Navigator.pop(context);
                        _alunoTextEditingController.text = "";
                      }
                    }),
              ],
            );
          });
    }
  }
}
