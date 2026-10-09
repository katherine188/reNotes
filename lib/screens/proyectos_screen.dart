import 'package:flutter/material.dart';
import '../models/proyecto.dart';
import '../models/nota.dart';
import 'notas_proyecto_screen.dart';
import '../services/app_state.dart';

class ProyectosScreen extends StatelessWidget {
  final List<Proyecto> proyectos;
  final List<Nota> notas;
  final Function(Proyecto) onEditarProyecto;
  final Function(Proyecto) onEliminarProyecto;
  final AppState appState;

  const ProyectosScreen({
    super.key,
    required this.proyectos,
    required this.notas,
    required this.onEditarProyecto,
    required this.onEliminarProyecto,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    if (proyectos.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Todavía no tienes proyectos',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text('Crea un proyecto para organizar tus investigaciones.'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: proyectos.length,
      itemBuilder: (context, index) {
        final proyecto = proyectos[index];

        final cantidadNotas = notas
            .where((nota) => nota.proyectoId == proyecto.id)
            .length;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          child: ListTile(
            onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(
               builder: (context) => NotasProyectoScreen(
                 proyecto: proyecto,
                 notas: notas,
                 appState: appState,
               ),
             ),
           );
         },
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.folder,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
           trailing: PopupMenuButton<String>(
  tooltip: 'Opciones del proyecto',
  onSelected: (opcion) {
    if (opcion == 'editar') {
      onEditarProyecto(proyecto);
    } else if (opcion == 'eliminar') {
      onEliminarProyecto(proyecto);
    }
  },
  itemBuilder: (context) => [
    const PopupMenuItem<String>(
      value: 'editar',
      child: Row(
        children: [
          Icon(Icons.edit_outlined),
          SizedBox(width: 8),
          Text('Editar'),
        ],
      ),
    ),
    const PopupMenuItem<String>(
      value: 'eliminar',
      child: Row(
        children: [
          Icon(Icons.delete_outline, color: Colors.red),
          SizedBox(width: 8),
          Text('Eliminar'),
        ],
      ),
    ),
  ],
),
            title: Text(
              proyecto.nombre,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(proyecto.descripcion),
                  const SizedBox(height: 10),
                  Text(
                    '$cantidadNotas ${cantidadNotas == 1 ? 'nota' : 'notas'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Modificado: ${_formatearFecha(proyecto.fechaModificacion)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatearFecha(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');

    return '$dia/$mes/${fecha.year}';
  }
}