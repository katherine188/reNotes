import 'package:flutter/material.dart';

class CrearProyectoScreen extends StatefulWidget {
  final String? nombreInicial;
  final String? descripcionInicial;

  const CrearProyectoScreen({
    super.key,
    this.nombreInicial,
    this.descripcionInicial,
  });

  @override
  State<CrearProyectoScreen> createState() =>
      _CrearProyectoScreenState();
}

class _CrearProyectoScreenState extends State<CrearProyectoScreen> {
  final _formKey = GlobalKey<FormState>();

 late final TextEditingController _nombreController;
late final TextEditingController _descripcionController;

@override
void initState() {
  super.initState();

  _nombreController = TextEditingController(
    text: widget.nombreInicial ?? '',
  );

  _descripcionController = TextEditingController(
    text: widget.descripcionInicial ?? '',
  );
}

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

 void _guardarProyecto() {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  Navigator.pop(context, {
    'nombre': _nombreController.text.trim(),
    'descripcion': _descripcionController.text.trim(),
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(
    widget.nombreInicial == null
        ? 'Nuevo proyecto'
        : 'Editar proyecto',
  ),
),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Organiza tu investigación',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Introduce los datos del proyecto que deseas crear.',
            ),
            const SizedBox(height: 24),

            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre del proyecto',
                hintText: 'Ej. Inteligencia Artificial',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.folder_outlined),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'El nombre del proyecto es obligatorio.';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción breve',
                hintText: '¿De qué trata tu investigación?',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.description_outlined),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: 4,
            ),

            const SizedBox(height: 28),

            FilledButton.icon(
              onPressed: _guardarProyecto,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Guardar proyecto'),
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