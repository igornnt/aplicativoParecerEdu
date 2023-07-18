import 'package:aplicativoescolas/models/escola_model.dart';
import 'package:aplicativoescolas/repositories/escolas_data_repository.dart';

abstract class EscolasListViewContract {
  void onLoadEscolasComplete(List<Escola> items);
  void onLoadEscolasError();
}

class EscolasListPresenter {
  EscolasListViewContract _view;
  EscolasDataRepository _repository;

  EscolasListPresenter(this._view) {
    this._repository = new EscolasDataRepository();
  }

  bool removeEscola(String id) {
    this._repository.remove(id);
  }

  void carregaEscolas() {
    this
        ._repository
        .buscaTodas()
        .then((dados) => this._view.onLoadEscolasComplete(dados))
        .catchError((onError) => this._view.onLoadEscolasError());
  }
}
