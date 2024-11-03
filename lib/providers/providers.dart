// providers/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dataProvider = FutureProvider<List<String>>((ref) async {
  // Obtener instancia de SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Cargar los datos guardados
  final data = prefs.getStringList('apiData') ?? [];
  return data;
});
