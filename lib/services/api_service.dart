// TODO Implement this library.// services/api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Método para consumir la API
  Future<void> fetchDataAndStore() async {
    final url = 'https://jsonplaceholder.typicode.com/posts';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Decodificar la respuesta
      final data = json.decode(response.body);

      // Obtener instancia de SharedPreferences
      final prefs = await SharedPreferences.getInstance();

      // Guardar los datos en Shared Preferences
      await prefs.setStringList(
          'apiData', List<String>.from(data.map((e) => e.toString())));
    } else {
      throw Exception('Error al cargar los datos');
    }
  }
}
