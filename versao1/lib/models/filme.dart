class Filme {
  int? id;
  String titulo;
  bool assistido;

  Filme({this.id, required this.titulo, this.assistido = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'assistido': assistido ? 1 : 0,
    };
  }

  factory Filme.fromMap(Map<String, dynamic> mapa) {
    return Filme(
      id: mapa['id'],
      titulo: mapa['titulo'],
      assistido: mapa['assistido'] == 1,
    );
  }
}
