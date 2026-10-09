import 'package:flutter/material.dart';

import '../models/nota.dart';
import '../services/app_state.dart';
import 'detalle_nota_screen.dart';

class BuscarScreen extends StatefulWidget {
  final AppState appState;

  const BuscarScreen({
    super.key,
    required this.appState,
  });

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> {
  final TextEditingController _busquedaController =
      TextEditingController();

  final Set<int> _etiquetasSeleccionadas = {};

  bool _coincidirTodas = true;
  int? _proyectoSeleccionado;

  String _normalizar(String texto) {
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

  List<Nota> get _notasFiltradas {
    final consulta = _normalizar(_busquedaController.text);

    return widget.appState.notas.where((nota) {
      final titulo = _normalizar(nota.titulo);
      final descripcion = _normalizar(nota.descripcion);

      final coincideProyecto = _proyectoSeleccionado == null ||
          nota.proyectoId == _proyectoSeleccionado;

      final coincideTexto = consulta.isEmpty ||
          titulo.contains(consulta) ||
          descripcion.contains(consulta);

      final coincideEtiquetas =
          _etiquetasSeleccionadas.isEmpty ||
          (_coincidirTodas
              ? _etiquetasSeleccionadas.every(
                  (id) => nota.etiquetaIds.contains(id),
                )
              : _etiquetasSeleccionadas.any(
                  (id) => nota.etiquetaIds.contains(id),
                ));

      return coincideTexto && 
           coincideEtiquetas &&
           coincideProyecto;
    }).toList();
  }

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar notas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _busquedaController,
              decoration: InputDecoration(
                labelText: 'Buscar notas',
                hintText: 'Escribe un título o una palabra...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  tooltip: 'Limpiar búsqueda',
                  onPressed: () {
                    _busquedaController.clear();
                    setState(() {});
                  },
                ),
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),

          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: DropdownButtonFormField<int?>(
    initialValue: _proyectoSeleccionado,
    decoration: const InputDecoration(
      labelText: 'Filtrar por proyecto',
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.folder_outlined),
    ),
    items: [
      const DropdownMenuItem<int?>(
        value: null,
        child: Text('Todos los proyectos'),
      ),
      ...widget.appState.proyectos.map((proyecto) {
        return DropdownMenuItem<int?>(
          value: proyecto.id,
          child: Text(proyecto.nombre),
        );
      }),
    ],
    onChanged: (valor) {
      setState(() {
        _proyectoSeleccionado = valor;
      });
    },
  ),
),

const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filtrar por etiquetas:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('Todas'),
                      selected: _coincidirTodas,
                      onSelected: (_) {
                        setState(() {
                          _coincidirTodas = true;
                        });
                      },
                    ),
                    ChoiceChip(
                      label: const Text('Alguna'),
                      selected: !_coincidirTodas,
                      onSelected: (_) {
                        setState(() {
                          _coincidirTodas = false;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: widget.appState.etiquetas.map((etiqueta) {
                    return FilterChip(
                      label: Text(etiqueta.nombre),
                      selected: _etiquetasSeleccionadas.contains(
                        etiqueta.id,
                      ),
                      onSelected: (seleccionada) {
                        setState(() {
                          if (seleccionada) {
                            _etiquetasSeleccionadas.add(etiqueta.id);
                          } else {
                            _etiquetasSeleccionadas.remove(etiqueta.id);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: _notasFiltradas.isEmpty
                ? const Center(
                    child: Text('No se encontraron notas.'),
                  )
                : ListView.separated(
                    itemCount: _notasFiltradas.length,
                    separatorBuilder: (context, index) {
                      return const Divider(height: 1);
                    },
                    itemBuilder: (context, index) {
                      final nota = _notasFiltradas[index];
                      final proyectosCoincidentes = widget.appState.proyectos
                         .where((proyecto) => proyecto.id == nota.proyectoId)
                         .toList();

                      final nombreProyecto = proyectosCoincidentes.isEmpty
                          ? 'Sin proyecto'
                          : proyectosCoincidentes.first.nombre;

                      final nombresEtiquetas = widget.appState.etiquetas
                         .where((etiqueta) => nota.etiquetaIds.contains(etiqueta.id))
                         .map((etiqueta) => etiqueta.nombre)
                         .toList();

                      return ListTile(
  leading: const Icon(Icons.note_outlined),
  title: Text(nota.titulo),
  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Proyecto: $nombreProyecto',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        nota.descripcion,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      if (nombresEtiquetas.isNotEmpty) ...[
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: nombresEtiquetas.map((nombre) {
            return Chip(
              label: Text(nombre),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize:
                  MaterialTapTargetSize.shrinkWrap,
            );
          }).toList(),
        ),
      ],
    ],
  ),
  trailing: const Icon(
    Icons.arrow_forward_ios,
    size: 16,
  ),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleNotaScreen(
          nota: nota,
          etiquetas: widget.appState.etiquetas,
          appState: widget.appState,
        ),
      ),
    );
  },
);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}