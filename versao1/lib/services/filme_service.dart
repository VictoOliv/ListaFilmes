import 'package:sqflite/sqflite.dart';

import '../models/filme.dart';

class FilmeService {
  Database? _banco;

  Future<Database> abrirBanco() async {
    _banco ??= await openDatabase(
      'filmes.db',
      version: 1,
      onCreate: (banco, versao) async {
        await banco.execute(
          'CREATE TABLE filmes ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'titulo TEXT NOT NULL, '
          'assistido INTEGER NOT NULL)',
        );
      },
    );
    return _banco!;
  }

  Future<void> inserir(Filme filme) async {
    final banco = await abrirBanco();
    await banco.insert('filmes', filme.toMap());
  }

  Future<List<Filme>> listar() async {
    final banco = await abrirBanco();
    final linhas = await banco.query('filmes', orderBy: 'id');
    return linhas.map((linha) => Filme.fromMap(linha)).toList();
  }

  Future<void> atualizar(Filme filme) async {
    final banco = await abrirBanco();
    await banco.update(
      'filmes',
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }
}
