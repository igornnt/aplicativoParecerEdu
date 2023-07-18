import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:aplicativoescolas/models/escola_model.dart';
import 'package:aplicativoescolas/presenters/escola_presenter.dart';
import 'package:aplicativoescolas/ui/escola_ui/cadastrar_escola_page.dart';
import 'package:aplicativoescolas/ui/escola_ui/escola_card_page.dart';
import 'package:toast/toast.dart';

class HomeInicial extends StatefulWidget {
  @override
  _HomeInicialState createState() => _HomeInicialState();
}

class _HomeInicialState extends State<HomeInicial>
    implements EscolasListViewContract {
  EscolasListPresenter _presenter;
  List<Escola> _escolas;
  bool _isLoading;

  _HomeInicialState() {
    this._presenter = new EscolasListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    this._isLoading = true;
    this._presenter.carregaEscolas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ParecerEdu"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: (this._escolas != null) ? this._escolas.length : 0,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CadastrarEscolaView(
                                  editar: true,
                                  textoParaAtualizar: this._escolas[index].nome,
                                  id: _escolas[index].id),
                            ));
                        Toast.show('Editado $index', context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
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
                          _presenter.removeEscola(_escolas[index].id);
                          _presenter.carregaEscolas();
                        });
                        Toast.show('Deletado ', context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      },
                    ),
                  )
                ],
                child:
                    CardEscolaView(_escolas[index].nome, _escolas[index].id)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CadastrarEscolaView(),
              ));
        },
        tooltip: "Adicione uma escola",
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void onLoadEscolasComplete(List<Escola> items) {
    this.setState(() {
      this._escolas = items;
      this._isLoading = false;
    });
  }

  @override
  void onLoadEscolasError() {
    // TODO: implement onLoadEscolasError
  }
}
