import 'package:flutter/material.dart';
import '../models/etiqueta.dart';
import '../models/nota.dart';
import '../services/app_state.dart';

class CrearNotaScreen extends StatefulWidget {
  final AppState appState;
  final Nota? notaExistente;

  const CrearNotaScreen({
    super.key,
    required this.appState,
    this.notaExistente,
  });

  @override
  State<CrearNotaScreen> createState() => _CrearNotaScreenState();
}

class _CrearNotaScreenState extends State<CrearNotaScreen> {
  final Set<int> _etiquetasSeleccionadas = {};

  final TextEditingController _nuevaEtiquetaController =
      TextEditingController();
      TextEditingController? _controladorAutocomplete;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tituloController =
      TextEditingController();

  final TextEditingController _descripcionController =
      TextEditingController();

      @override
void initState() {
  super.initState();

  final nota = widget.notaExistente;

  if (nota != null) {
    _tituloController.text = nota.titulo;
    _descripcionController.text = nota.descripcion;
    _etiquetasSeleccionadas.addAll(nota.etiquetaIds);
  }
}

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _nuevaEtiquetaController.dispose();
    super.dispose();
  }

  void _agregarEtiqueta() {
  final nombre = _nuevaEtiquetaController.text.trim();

  if (nombre.isEmpty) {
    return;
  }

  final etiqueta = widget.appState.agregarEtiqueta(nombre);

  if (etiqueta == null) {
    return;
  }

  setState(() {
    _etiquetasSeleccionadas.add(etiqueta.id);
    _nuevaEtiquetaController.clear();
  });

  FocusScope.of(context).unfocus();
}

 void _guardarNota() {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  Navigator.pop(context, {
    'titulo': _tituloController.text.trim(),
    'descripcion': _descripcionController.text.trim(),
    'etiquetaIds': _etiquetasSeleccionadas.join(','),
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(
    widget.notaExistente == null
        ? 'Nueva nota'
        : 'Editar nota',
  ),
),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Escribe tu nota',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Guarda la información importante de tu investigación.',
            ),
            const SizedBox(height: 24),

            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título de la nota',
                hintText: 'Ej. Introducción al tema',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'El título es obligatorio.';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            Autocomplete<Etiqueta>(
  displayStringForOption: (etiqueta) => etiqueta.nombre,
  optionsBuilder: (TextEditingValue valor) {
    final texto = valor.text.trim();

    if (texto.isEmpty) {
      return const Iterable<Etiqueta>.empty();
    }

    String normalizar(String texto) {
      return texto
          .toLowerCase()
          .replaceAll('á', 'a')
          .replaceAll('é', 'e')
          .replaceAll('í', 'i')
          .replaceAll('ó', 'o')
          .replaceAll('ú', 'u')
          .replaceAll('ü', 'u');
    }

    final consulta = normalizar(texto);

    return widget.appState.etiquetas.where(
      (etiqueta) =>
          normalizar(etiqueta.nombre).contains(consulta),
    );
  },
  onSelected: (Etiqueta etiqueta) {
  setState(() {
    _etiquetasSeleccionadas.add(etiqueta.id);
    _controladorAutocomplete?.clear();
    _nuevaEtiquetaController.clear();
  });
},
  fieldViewBuilder: (
    context,
    textEditingController,
    focusNode,
    onFieldSubmitted,
  ) {
    _controladorAutocomplete = textEditingController;

    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: 'Buscar o crear etiqueta',
        hintText: 'Ej. Programación',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.label_outline),
        suffixIcon: IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Crear etiqueta',
          onPressed: () {
            _nuevaEtiquetaController.text =
                textEditingController.text;
            _agregarEtiqueta();
            textEditingController.clear();
          },
        ),
      ),
      textCapitalization: TextCapitalization.sentences,
      onChanged: (valor) {
        _nuevaEtiquetaController.text = valor;
      },
      onFieldSubmitted: (_) {
        _nuevaEtiquetaController.text =
            textEditingController.text;
        _agregarEtiqueta();
        textEditingController.clear();
      },
    );
  },
),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.appState.etiquetas.map((etiqueta) {
                final seleccionada =
                    _etiquetasSeleccionadas.contains(etiqueta.id);

                return FilterChip(
                  label: Text(etiqueta.nombre),
                  selected: seleccionada,
                  onSelected: (valor) {
                    setState(() {
                      if (valor) {
                        _etiquetasSeleccionadas.add(etiqueta.id);
                      } else {
                        _etiquetasSeleccionadas.remove(etiqueta.id);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Escribe aquí el contenido de tu nota...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.description_outlined),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: 12,
              minLines: 6,
            ),

            const SizedBox(height: 28),

            FilledButton.icon(
  onPressed: _guardarNota,
  icon: const Icon(Icons.save_outlined),
  label: Text(
    widget.notaExistente == null
        ? 'Guardar nota'
        : 'Guardar cambios',
  ),
),

            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}