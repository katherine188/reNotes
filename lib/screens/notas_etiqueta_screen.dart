import 'package:flutter/material.dart';

import '../models/etiqueta.dart';
import '../models/nota.dart';
import '../models/proyecto.dart';
import '../services/app_state.dart';
import 'detalle_nota_screen.dart';

class NotasEtiquetaScreen extends StatefulWidget {
  final AppState appState;
  final Etiqueta etiqueta;

  const NotasEtiquetaScreen({
    super.key,
    required this.appState,
    required this.etiqueta,
  });

  @override
  State<NotasEtiquetaScreen> createState() =>
      _NotasEtiquetaScreenState();
}

class _NotasEtiquetaScreenState extends State<NotasEtiquetaScreen> {
  @override
  Widget build(BuildContext context) {
    final notasFiltradas = widget.appState.notas
        .where(
          (nota) =>
              nota.etiquetaIds.contains(widget.etiqueta.id),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.etiqueta.nombre),
      ),
      body: notasFiltradas.isEmpty
          ? const Center(
              child: Text('Esta etiqueta todavía no tiene notas.'),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notasFiltradas.length,
              separatorBuilder: (context, index) {
                return const Divider(height: 1);
              },
              itemBuilder: (context, index) {
                final Nota nota = notasFiltradas[index];

                final proyectosCoincidentes =
                    widget.appState.proyectos
                        .where(
                          (elemento) =>
                              elemento.id == nota.proyectoId,
                        )
                        .toList();

                final Proyecto? proyecto =
                    proyectosCoincidentes.isEmpty
                        ? null
                        : proyectosCoincidentes.first;

                return ListTile(
                  leading: const Icon(Icons.note_outlined),
                  title: Text(nota.titulo),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Proyecto: ${proyecto?.nombre ?? "No disponible"}',
                      ),
                      const SizedBox(height: 4),
                      Text(
                        nota.descripcion,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  onTap: () async {
                    final resultado =
                        await Navigator.of(context).push<bool>(
                      MaterialPageRoute<bool>(
                        builder: (context) => DetalleNotaScreen(
                          nota: nota,
                          etiquetas: widget.appState.etiquetas,
                          appState: widget.appState,
                        ),
                      ),
                    );

                    if (!mounted) {
                      return;
                    }

                    if (resultado == true) {
                      setState(() {});
                    }
                  },
                );
              },
            ),
    );
  }
}