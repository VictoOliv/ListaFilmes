import 'package:flutter/material.dart';

import '../models/filme.dart';
import '../services/filme_service.dart';

class FilmeViewModel extends ChangeNotifier {
  final FilmeService service = FilmeService();
  List<Filme> filmes = [];

  Future<void> carregarFilmes() async {
    filmes = await service.listar();
    notifyListeners();
  }

  Future<void> adicionarFilme(String titulo) async {
    if (titulo.trim().isEmpty) return;
    await service.inserir(Filme(titulo: titulo.trim()));
    await carregarFilmes();
  }

  Future<void> alterarAssistido(Filme filme, bool assistido) async {
    filme.assistido = assistido;
    await service.atualizar(filme);
    await carregarFilmes();
  }
}
