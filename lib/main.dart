import 'package:flutter/material.dart';
import 'services/app_state.dart';
import 'screens/inicio_screen.dart';

void main() {
  final appState = AppState();

  runApp(ReNotesApp(appState: appState));
}

class ReNotesApp extends StatelessWidget {
  final AppState appState;

  const ReNotesApp({
    super.key,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReNotes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: InicioScreen(appState: appState),
    );
  }
}