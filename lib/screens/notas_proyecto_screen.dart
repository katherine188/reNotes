import 'package:flutter/material.dart';
import '../models/proyecto.dart';
import '../models/nota.dart';
import 'crear_nota_screen.dart';
import '../services/app_state.dart';
import 'detalle_nota_screen.dart';

class NotasProyectoScreen extends StatefulWidget {
  final Proyecto proyecto;
  final List<Nota> notas;
  final AppState appState;

  const NotasProyectoScreen({
    super.key,
    required this.proyecto,
    required this.notas,
    required this.appState,
  });

  @override
  State<NotasProyectoScreen> createState() =>
      _NotasProyectoScreenState();
}

class _NotasProyectoScreenState extends State<NotasProyectoScreen> {
 @override
  Widget build(BuildContext context) {
    final notasDelProyecto = widget.notas
        .where((nota) => nota.proyectoId == widget.proyecto.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.proyecto.nombre),
      ),
      body: notasDelProyecto.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_alt_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Este proyecto todavía no tiene notas.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notasDelProyecto.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final nota = notasDelProyecto[index];

                return Card(
  child: ListTile(
    contentPadding: const EdgeInsets.all(16),

    onTap: () async{
     final resultado = await Navigator.push<bool>(
  context,
  MaterialPageRoute<bool>(
    builder: (context) => DetalleNotaScreen(
      nota: nota,
      etiquetas: widget.appState.etiquetas,
      appState: widget.appState,
    ),
  ),
);

if (resultado == true && mounted) {
  setState(() {});
}
    },

    leading: const CircleAvatar(
      child: Icon(Icons.description_outlined),
    ),

    title: Text(
      nota.titulo,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),

    subtitle: Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        nota.descripcion,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    ),

    trailing: PopupMenuButton<String>(
  onSelected: (opcion) async {
    if (opcion == 'editar') {
      final resultado =
          await Navigator.push<Map<String, String>>(
        context,
        MaterialPageRoute(
          builder: (context) => CrearNotaScreen(
            appState: widget.appState,
            notaExistente: nota,
          ),
        ),
      );

      if (resultado != null) {
        final etiquetaIds = (resultado['etiquetaIds'] ?? '')
            .split(',')
            .where((id) => id.isNotEmpty)
            .map(int.parse)
            .toList();

        widget.appState.editarNota(
          id: nota.id,
          titulo: resultado['titulo']!,
          descripcion: resultado['descripcion']!,
          etiquetaIds: etiquetaIds,
        );

        setState(() {});
      }
    }

    if (opcion == 'eliminar') {
      if (!mounted) return;
      final confirmar = await showDialog<bool>(
        context: this.context,
        useRootNavigator: true,
        builder: (context) => AlertDialog(
          title: const Text('Eliminar nota'),
          content: Text(
            '¿Estás segura de que deseas eliminar '
            '"${nota.titulo}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Eliminar'),
            ),
          ],
        ),
      );

      if (!mounted) return;
      if (confirmar == true) {
  widget.appState.eliminarNota(nota.id);

  setState(() {});
}
    }
  },
  itemBuilder: (context) => [
    const PopupMenuItem<String>(
      value: 'editar',
      child: Row(
        children: [
          Icon(Icons.edit_outlined),
          SizedBox(width: 8),
          Text('Editar nota'),
        ],
      ),
    ),
    const PopupMenuItem<String>(
      value: 'eliminar',
      child: Row(
        children: [
          Icon(Icons.delete_outline),
          SizedBox(width: 8),
          Text('Eliminar nota'),
        ],
      ),
    ),
  ],
),
  ),
);
        },
      ),
            floatingActionButton: FloatingActionButton(
      onPressed: () async {
        final resultado = await Navigator.push<Map<String, String>>(
          context,
          MaterialPageRoute(
            builder: (context) => CrearNotaScreen(
              appState: widget.appState,
            ),
          ),
        );

        if (resultado != null) {
  final etiquetaIds = (resultado['etiquetaIds'] ?? '')
      .split(',')
      .where((id) => id.isNotEmpty)
      .map(int.parse)
      .toList();

  if (resultado['id'] != null) {
    widget.appState.editarNota(
      id: int.parse(resultado['id']!),
      titulo: resultado['titulo']!,
      descripcion: resultado['descripcion']!,
      etiquetaIds: etiquetaIds,
    );
  } else {
    widget.appState.agregarNota(
      proyectoId: widget.proyecto.id,
      titulo: resultado['titulo']!,
      descripcion: resultado['descripcion']!,
      etiquetaIds: etiquetaIds,
    );
  }

  setState(() {});
}
      },
      child: const Icon(Icons.add),
    ),
    );
    
  }
}