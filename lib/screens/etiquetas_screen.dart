import 'package:flutter/material.dart';
import '../models/etiqueta.dart';
import '../services/app_state.dart';
import '../models/nota.dart';
import 'notas_etiqueta_screen.dart';


class EtiquetasScreen extends StatefulWidget {
  final AppState appState;

  const EtiquetasScreen({
    super.key,
    required this.appState,
  });

  @override
  State<EtiquetasScreen> createState() => _EtiquetasScreenState();
}

class _EtiquetasScreenState extends State<EtiquetasScreen> {
  final TextEditingController _busquedaController = TextEditingController();

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
  List<Etiqueta> get _etiquetasFiltradas {
    final consulta = _normalizar(_busquedaController.text);

    return widget.appState.etiquetas.where((etiqueta) {
      return _normalizar(etiqueta.nombre).contains(consulta);
    }).toList();
  }

  void _crearEtiqueta() {
    final controller = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Nueva etiqueta'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Nombre de la etiqueta',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                controller.dispose();
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                final nombre = controller.text.trim();

                if (nombre.isEmpty) {
                  return;
                }

                final cantidadAntes =
                    widget.appState.etiquetas.length;

                widget.appState.agregarEtiqueta(nombre);

                final seCreo =
                    widget.appState.etiquetas.length > cantidadAntes;

                Navigator.pop(dialogContext);
                controller.dispose();

                setState(() {});

                if (!seCreo) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Esa etiqueta ya existe.'),
                    ),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  List<Nota> _obtenerNotasDeEtiqueta(Etiqueta etiqueta) {
  return widget.appState.notas
      .where((nota) => nota.etiquetaIds.contains(etiqueta.id))
      .toList();
}



  void _renombrarEtiqueta(Etiqueta etiqueta) {
    final controller = TextEditingController(
      text: etiqueta.nombre,
    );

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Renombrar etiqueta'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Nuevo nombre',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) {
              _guardarNuevoNombre(
                etiqueta,
                controller.text,
                dialogContext,
              );
              controller.dispose();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                controller.dispose();
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                _guardarNuevoNombre(
                  etiqueta,
                  controller.text,
                  dialogContext,
                );
                controller.dispose();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _guardarNuevoNombre(
    Etiqueta etiqueta,
    String nuevoNombre,
    BuildContext dialogContext,
  ) {
    final nombreLimpio = nuevoNombre.trim();

    if (nombreLimpio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El nombre de la etiqueta es obligatorio.'),
        ),
      );
      return;
    }

    final actualizado = widget.appState.renombrarEtiqueta(
      id: etiqueta.id,
      nuevoNombre: nombreLimpio,
    );

    if (!actualizado) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ya existe una etiqueta con ese nombre.',
          ),
        ),
      );
      return;
    }

    Navigator.pop(dialogContext);
    setState(() {});
  }

  void _eliminarEtiqueta(Etiqueta etiqueta) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Eliminar etiqueta'),
        content: Text(
          '¿Quieres eliminar la etiqueta "${etiqueta.nombre}"?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
             widget.appState.eliminarEtiqueta(etiqueta.id);

              Navigator.pop(dialogContext);

              setState(() {});
            },
            child: const Text('Eliminar'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etiquetas'),
      ),
      body: Column(
        
  children: [
    Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _busquedaController,
        decoration: InputDecoration(
          labelText: 'Buscar etiquetas',
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
    Expanded(
      child: _etiquetasFiltradas.isEmpty
          ? const Center(
              child: Text('No se encontraron etiquetas.'),
            )
          : ListView.separated(
              itemCount: _etiquetasFiltradas.length,
              separatorBuilder: (context, index) {
                return const Divider(height: 1);
              },
              itemBuilder: (context, index) {
                final etiqueta = _etiquetasFiltradas[index];
                final cantidadNotas = _obtenerNotasDeEtiqueta(etiqueta) .length;

                return ListTile(
  leading: const Icon(Icons.label_outline),
  title: Text(etiqueta.nombre),
  subtitle: Text(
    cantidadNotas == 1 ? '1 nota' : '$cantidadNotas notas',
  ),
  onTap: () {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return NotasEtiquetaScreen(
          appState: widget.appState,
          etiqueta: etiqueta,
        );
      },
    ),
  );
},
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: const Icon(Icons.edit_outlined),
        tooltip: 'Renombrar etiqueta',
        onPressed: () {
          _renombrarEtiqueta(etiqueta);
        },
      ),
      IconButton(
        icon: const Icon(Icons.delete_outline),
        tooltip: 'Eliminar etiqueta',
        onPressed: () {
          _eliminarEtiqueta(etiqueta);
        },
      ),
    ],
  ),
);
        },
     ),
    ),
  ],
),

 floatingActionButton: FloatingActionButton(onPressed: _crearEtiqueta,
        tooltip: 'Crear etiqueta',
        child: const Icon(Icons.add),
        ),
    );
  }
}