class Nota {
  final int id;
  final int proyectoId;
  String titulo;
  String descripcion;
  final DateTime fechaCreacion;
  DateTime fechaModificacion;
  List<int> etiquetaIds;

  Nota({
    required this.id,
    required this.proyectoId,
    required this.titulo,
    required this.descripcion,
    required this.fechaCreacion,
    required this.fechaModificacion,
    required this.etiquetaIds,
  });
}