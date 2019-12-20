import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parecer_app/models/criterio_model.dart';
import 'package:parecer_app/repositories/criterio_data_repository.dart';
import 'package:parecer_app/ui/criterios_ui/card_criterios_page.dart';
import 'package:toast/toast.dart';

import 'cadastro_criterios_linguagens_page.dart';

class CriterioLinguagensView extends StatefulWidget {

  String turmaId;
  String escolaId;
  String tituloAppBar;

  CriterioLinguagensView({String turmaID, String escolaID, String titulo}){
    this.turmaId = turmaID;
    this.escolaId = escolaID;
    this.tituloAppBar = titulo;

  }

  @override
  _CriterioLinguagensViewState createState() => _CriterioLinguagensViewState(this.turmaId,this.escolaId,this.tituloAppBar);
}

class _CriterioLinguagensViewState extends State<CriterioLinguagensView> {

  String turmaId;
  String escolaId;
  String tituloAppBar;
  bool avaliar = false;
  List<Criterio> criterios;
  CriterioDataRepository criterioDataRepository;

  _CriterioLinguagensViewState(String turmaID, String escolaID, String titulo, {this.avaliar}){
    this.turmaId = turmaID;
    this.escolaId = escolaID;
    this.tituloAppBar = titulo;
    this.criterioDataRepository = CriterioDataRepository(turmaID,escolaID);
    onLoadCriteriosComplete();
  }

  void initState() {
    super.initState();
    this.onLoadCriteriosComplete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tituloAppBar),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: (this.criterios != null) ? this.criterios.length : 0,
        itemBuilder: (context, index){
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
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => CadastrarCriteriosLinguagensView(turmaId, escolaId,
                                editar: true, desc: criterios[index].descricao, id: criterios[index].id),
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
                      onTap: (){
                        setState(() {
                          removeCriterio(criterios[index].id);
                          onLoadCriteriosComplete();
                        });
                        Toast.show('Deletado ', context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM
                        );
                      },
                    ),
                  )
                ],
                child: CriteriosView(criterios[index].descricao,escolaId,turmaId,criterios[index].id,avaliar: avaliar),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => CadastrarCriteriosLinguagensView(turmaId, escolaId),
              )
          );
        },
        tooltip: "Adicione um critério",
        child: Icon(Icons.add),
      ),
    );
  }
  
  void removeCriterio(String id){
    this.criterioDataRepository.remove(id);
  }

  void onLoadCriteriosComplete() {
    this.criterioDataRepository.buscaTodasPelaArea("LINGUAGENS").then((dados) => {
      this.setState(() {
        this.criterios = dados;
        print(criterios);
      })
    });
  }
}