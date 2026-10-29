import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'pages/pagina_inicial.dart';
import 'viewmodels/filme_viewmodel.dart';

void main() {
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => FilmeViewModel()..carregarFilmes(),
      child: const AppFilmes(),
    ),
  );
}

class AppFilmes extends StatelessWidget {
  const AppFilmes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Lista de Filmes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.red),
      home: const PaginaInicial(),
    );
  }
}
