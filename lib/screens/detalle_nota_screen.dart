import 'package:flutter/material.dart';
import '../models/nota.dart';
import '../models/etiqueta.dart';
import '../models/proyecto.dart';
import '../services/app_state.dart';
import 'crear_nota_screen.dart';
import 'notas_etiqueta_screen.dart';

class DetalleNotaScreen extends StatelessWidget {
  final Nota nota;
  final List<Etiqueta> etiquetas;
  final AppState appState;

  const DetalleNotaScreen({
    super.key,
    required this.nota,
    required this.etiquetas,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    final etiquetasDeLaNota = etiquetas
        .where((etiqueta) => nota.etiquetaIds.contains(etiqueta.id))
        .toList();

        final proyectosCoincidentes = appState.proyectos
      .where((proyecto) => proyecto.id == nota.proyectoId)
      .toList();

  final Proyecto? proyecto = proyectosCoincidentes.isEmpty
      ? null
      : proyectosCoincidentes.first;

    return Scaffold(
      appBar: AppBar(
  title: const Text('Detalle de la nota'),
  actions: [
    IconButton(
  icon: const Icon(Icons.edit_outlined),
  tooltip: 'Editar nota',
  onPressed: () async {
    final resultado = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute<Map<String, dynamic>>(
        builder: (context) => CrearNotaScreen(
          appState: appState,
          notaExistente: nota,
        ),
      ),
    );

    if (resultado == null || !context.mounted) {
      return;
    }

    final etiquetaIdsTexto = resultado['etiquetaIds'] as String;

    final etiquetaIds = etiquetaIdsTexto.isEmpty
        ? <int>[]
        : etiquetaIdsTexto
            .split(',')
            .map((id) => int.parse(id))
            .toList();

    appState.editarNota(
      id: nota.id,
      titulo: resultado['titulo'] as String,
      descripcion: resultado['descripcion'] as String,
      etiquetaIds: etiquetaIds,
    );

    if (context.mounted) {
      Navigator.of(context).pop(true);
    }
  },
),
   IconButton(
  icon: const Icon(Icons.delete_outline),
  tooltip: 'Eliminar nota',
  onPressed: () async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Eliminar nota'),
          content: Text(
            '¿Estás seguro de que deseas eliminar "${nota.titulo}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmar != true || !context.mounted) {
      return;
    }

    appState.eliminarNota(nota.id);

    if (context.mounted) {
      Navigator.of(context).pop(true);
    }
  },
),
  ],
),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nota.titulo,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
Text(
  'Proyecto: ${proyecto?.nombre ?? 'Sin proyecto'}',
  style: Theme.of(context).textTheme.titleMedium,
),
const SizedBox(height: 12),
Text(
  'Creada: ${_formatearFecha(nota.fechaCreacion)}',
  style: Theme.of(context).textTheme.bodySmall,
),
            const SizedBox(height: 4),
            Text(
              'Última modificación: '
              '${_formatearFecha(nota.fechaModificacion)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            Text(
              'Descripción',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              nota.descripcion.isEmpty
                  ? 'Esta nota no tiene descripción.'
                  : nota.descripcion,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'Etiquetas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            if (etiquetasDeLaNota.isEmpty)
              const Text('Esta nota no tiene etiquetas.')
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
               children: etiquetasDeLaNota.map((etiqueta) {
  return ActionChip(
    avatar: const Icon(
      Icons.label_outline,
      size: 18,
    ),
    label: Text(etiqueta.nombre),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NotasEtiquetaScreen(
            appState: appState,
            etiqueta: etiqueta,
          ),
        ),
      );
    },
  );
}).toList(),
              ),
          ],
        ),
      ),
    );
  }

  String _formatearFecha(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');
    final anio = fecha.year.toString();

    return '$dia/$mes/$anio';
  }
}