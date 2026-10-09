import 'package:flutter/material.dart';
import '../services/app_state.dart';
import 'proyectos_screen.dart';
import 'crear_proyecto_screen.dart';
import 'etiquetas_screen.dart';
import 'buscar_screen.dart';

class InicioScreen extends StatefulWidget {
  final AppState appState;

  const InicioScreen({
    super.key,
    required this.appState,
  });

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  int _indiceSeleccionado = 0;

  List<Widget> get _pantallas => [
  ProyectosScreen(
    proyectos: widget.appState.proyectos,
    notas: widget.appState.notas,
    appState: widget.appState,
    onEditarProyecto: (proyecto) async {
      final resultado = await Navigator.push<Map<String, String>>(
        context,
        MaterialPageRoute(
          builder: (context) => CrearProyectoScreen(
            nombreInicial: proyecto.nombre,
            descripcionInicial: proyecto.descripcion,
          ),
        ),
      );

      if (resultado != null) {
        widget.appState.editarProyecto(
          id: proyecto.id,
          nombre: resultado['nombre']!,
          descripcion: resultado['descripcion']!,
        );

        setState(() {});
      }
    },
    onEliminarProyecto: (proyecto) async {
      final confirmar = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Eliminar proyecto'),
          content: Text(
            '¿Estás segura de que deseas eliminar '
            '"${proyecto.nombre}" y todas sus notas?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar'),
            ),
          ],
        ),
      );

      if (confirmar == true) {
        widget.appState.eliminarProyecto(proyecto.id);
        setState(() {});
      }
    },
  ),
  EtiquetasScreen(appState: widget.appState,),
  BuscarScreen(appState: widget.appState),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ReNotes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
     body: IndexedStack(
  index: _indiceSeleccionado,
  children: _pantallas,
),

      floatingActionButton: _indiceSeleccionado == 0
    ? FloatingActionButton(
        onPressed: () async {
          final resultado = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(
              builder: (context) => const CrearProyectoScreen(),
            ),
          );

          if (resultado != null) {
            widget.appState.agregarProyecto(
            nombre: resultado['nombre']!,
             descripcion: resultado['descripcion']!,
           );

          setState(() {});
        }
        },
        child: const Icon(Icons.add),
      )
    : null,

      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceSeleccionado,
        onDestinationSelected: (int indice) {
          setState(() {
            _indiceSeleccionado = indice;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Proyectos',
          ),
          NavigationDestination(
            icon: Icon(Icons.sell_outlined),
            selectedIcon: Icon(Icons.sell),
            label: 'Etiquetas',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search),
            label: 'Buscar',
          ),
        ],
      ),
    );
  }
}