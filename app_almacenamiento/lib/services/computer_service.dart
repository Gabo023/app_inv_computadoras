// Ejemplo de estructura de la clase de servicio
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/computer.dart';

class ComputerService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/computadoras/';

  // --- R (Read): Listar todas las computadoras ---
  Future<List<Computer>> fetchComputers() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      // Mapear la lista JSON a una lista de objetos Computer
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Computer.fromJson(data)).toList();
    } else {
      throw Exception('Fallo al cargar las computadoras.');
    }
  }

  // --- C (Create): Guardar una nueva computadora ---
  Future<Computer> createComputer(Computer computer) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(computer.toJson()),
    );

    if (response.statusCode == 201) {
      // 201 Created
      return Computer.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fallo al crear la computadora.');
    }
  }

  // --- U (Update): Actualizar una computadora existente ---
  Future<Computer> updateComputer(Computer computer) async {
    final response = await http.put(
      // Tu corrección de la URL (con la barra al final) es correcta
      Uri.parse('$_baseUrl${computer.id}/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(computer.toJson()),
    );

    // --- ¡ESTE ES EL CÓDIGO QUE TE FALTA! ---
    // Debes verificar la respuesta del servidor
    if (response.statusCode == 200) {
      // Si el servidor actualizó (200 OK), devuelve el objeto actualizado
      return Computer.fromJson(json.decode(response.body));
    } else {
      // Si el servidor falló, lanza la excepción que ya estás viendo
      throw Exception('Fallo al actualizar la computadora.');
    }
    // ----------------------------------------
  }

  // --- D (Delete): Eliminar una computadora ---
  Future<void> deleteComputer(int id) async {
    // Añade la barra al final, antes del paréntesis
    final response = await http.delete(Uri.parse('$_baseUrl$id/'));

    if (response.statusCode != 204) {
      // 204 No Content
      throw Exception('Fallo al eliminar la computadora.');
    }
  }
}
