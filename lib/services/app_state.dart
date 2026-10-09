import '../data/datos_prueba.dart';
import '../models/proyecto.dart';
import '../models/nota.dart';
import '../models/etiqueta.dart';

class AppState {
  final List<Proyecto> proyectos = List.from(proyectosPrueba);
  final List<Nota> notas = List.from(notasPrueba);
  final List<Etiqueta> etiquetas = List.from(etiquetasPrueba);

  int _siguienteProyectoId = 4;
  int _siguienteNotaId = 16;
  int _siguienteEtiquetaId = 9;

  // AGREGAR PROYECTO
  void agregarProyecto({
    required String nombre,
    required String descripcion,
  }) {
    final ahora = DateTime.now();

    proyectos.add(
      Proyecto(
        id: _siguienteProyectoId++,
        nombre: nombre,
        descripcion: descripcion,
        fechaCreacion: ahora,
        fechaModificacion: ahora,
      ),
    );
  }

  // EDITAR PROYECTO
  void editarProyecto({
    required int id,
    required String nombre,
    required String descripcion,
  }) {
    final indice = proyectos.indexWhere(
      (proyecto) => proyecto.id == id,
    );

    if (indice == -1) {
      return;
    }

    proyectos[indice].nombre = nombre;
    proyectos[indice].descripcion = descripcion;
    proyectos[indice].fechaModificacion = DateTime.now();
  }

  // ELIMINAR PROYECTO
  void eliminarProyecto(int id) {
    proyectos.removeWhere((proyecto) => proyecto.id == id);

    notas.removeWhere((nota) => nota.proyectoId == id);
  }

  // AGREGAR NOTA
  void agregarNota({
    required int proyectoId,
    required String titulo,
    required String descripcion,
    List<int> etiquetaIds = const [],
  }) {
    final ahora = DateTime.now();

    notas.add(
      Nota(
        id: _siguienteNotaId++,
        proyectoId: proyectoId,
        titulo: titulo,
        descripcion: descripcion,
        fechaCreacion: ahora,
        fechaModificacion: ahora,
        etiquetaIds: List<int>.from(etiquetaIds),
      ),
    );
  }

  // EDITAR NOTA
  void editarNota({
    required int id,
    required String titulo,
    required String descripcion,
    required List<int> etiquetaIds,
  }) {
    final indice = notas.indexWhere(
      (nota) => nota.id == id,
    );

    if (indice == -1) {
      return;
    }

    notas[indice].titulo = titulo;
    notas[indice].descripcion = descripcion;
    notas[indice].etiquetaIds = List<int>.from(etiquetaIds);
    notas[indice].fechaModificacion = DateTime.now();
  }

  //ELIMINAR NOTA
  void eliminarNota(int id) {
  notas.removeWhere((nota) => nota.id == id);
}

  // NORMALIZAR NOMBRES DE ETIQUETAS
  String _normalizarEtiqueta(String texto) {
    return texto
        .trim()
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u');
  }

  // AGREGAR ETIQUETA
  Etiqueta? agregarEtiqueta(String nombre) {
    final nombreLimpio = nombre.trim();

    if (nombreLimpio.isEmpty) {
      return null;
    }

    final nombreNormalizado = _normalizarEtiqueta(nombreLimpio);

    for (final etiqueta in etiquetas) {
      if (_normalizarEtiqueta(etiqueta.nombre) ==
          nombreNormalizado) {
        return etiqueta;
      }
    }

    final nuevaEtiqueta = Etiqueta(
      id: _siguienteEtiquetaId++,
      nombre: nombreLimpio,
    );

    etiquetas.add(nuevaEtiqueta);

    return nuevaEtiqueta;
  }

  // RENOMBRAR ETIQUETA
  bool renombrarEtiqueta({
    required int id,
    required String nuevoNombre,
  }) {
    final nombreLimpio = nuevoNombre.trim();

    if (nombreLimpio.isEmpty) {
      return false;
    }

    final etiqueta = etiquetas.firstWhere(
      (elemento) => elemento.id == id,
      orElse: () => Etiqueta(id: -1, nombre: ''),
    );

    if (etiqueta.id == -1) {
      return false;
    }

    final nombreNormalizado = _normalizarEtiqueta(nombreLimpio);

    for (final otraEtiqueta in etiquetas) {
      if (otraEtiqueta.id != id &&
          _normalizarEtiqueta(otraEtiqueta.nombre) ==
              nombreNormalizado) {
        return false;
      }
    }

    etiqueta.nombre = nombreLimpio;

    return true;
  }

  void eliminarEtiqueta(int id) {
  etiquetas.removeWhere(
    (etiqueta) => etiqueta.id == id,
  );

  for (final nota in notas) {
    nota.etiquetaIds.remove(id);
  }
}
}