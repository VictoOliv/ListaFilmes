import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/filme_viewmodel.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final controleTitulo = TextEditingController();

  @override
  void dispose() {
    controleTitulo.dispose();
    super.dispose();
  }

  Future<void> adicionar() async {
    await context.read<FilmeViewModel>().adicionarFilme(controleTitulo.text);
    controleTitulo.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Lista de Filmes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controleTitulo,
              decoration: const InputDecoration(hintText: 'Digite o nome do filme'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: adicionar, child: const Text('Adicionar')),
            const Divider(height: 32),
            Expanded(
              child: Consumer<FilmeViewModel>(
                builder: (context, viewModel, child) {
                  return ListView.builder(
                    itemCount: viewModel.filmes.length,
                    itemBuilder: (context, indice) {
                      final filme = viewModel.filmes[indice];
                      return ListTile(
                        leading: Text('${indice + 1}'),
                        title: Text(
                          filme.titulo,
                          style: TextStyle(
                            decoration: filme.assistido ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        trailing: Checkbox(
                          value: filme.assistido,
                          onChanged: (valor) => viewModel.alterarAssistido(filme, valor!),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
