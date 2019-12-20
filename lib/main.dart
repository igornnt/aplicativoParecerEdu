import 'package:flutter/material.dart';
import 'package:parecer_app/repositories/alunos_data_repository.dart';
import 'package:parecer_app/ui/escola_ui/home_escola_page.dart';

import 'models/avaliacao_model.dart';

void main() {
  AlunosDataRepository repository = AlunosDataRepository("6e4hMLqqvMSjdJDpY6YT", "4iioGPjlTM2UKZhKyw4r");
  repository.buscaTodasAsAvaliacoesDosAlunos().then((resultado) => {
    print(resultado.length)
  });

  runApp(
    MaterialApp(
      home: HomeInicial(),
      debugShowCheckedModeBanner: false,
    )
  );
}